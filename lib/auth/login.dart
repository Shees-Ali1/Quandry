import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:quandry/auth/forgot_password.dart';
import 'package:quandry/auth/signup.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/controller/auth_controller.dart';

import '../const/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import 'forgot_phone_number.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authVM = Get.find<AuthController>();
  final LocalStorage storage = localStorage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _rememberMe = false;


  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    String? email = storage.getItem('email');
    String? password = storage.getItem('password');

    if (email != null && password != null) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
        _rememberMe = true;
      });
    }
  }

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  // Method to handle user login
  Future<void> _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          // backgroundColor: Colors.red,
          colorText: Colors.red);
      return;
    }

    try {
      authVM.simple_loading.value = true;

      // Attempt to sign in the user with Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_rememberMe) {
        storage.setItem('email', email);
        storage.setItem('password', password);
      } else {
        storage.removeItem('email');
        storage.removeItem('password');
      }

      // If successful, navigate to the AppNavBar
      storage.setItem("logged_in_by", "email");
      authVM.simple_loading.value = false;

      Get.to(() => AppNavBar());
    } on FirebaseAuthException catch (e) {
      authVM.simple_loading.value = false;

      if (e.code == 'user-not-found') {
        // Show Snackbar if user is not registered
        Get.snackbar("Error", "User is not registered",
            // backgroundColor: Colors.red,
            colorText: Colors.red);
      } else if (e.code == 'wrong-password') {
        // Show Snackbar if the password is incorrect
        Get.snackbar("Error", "Incorrect password",
            // backgroundColor: Colors.red,
            colorText: Colors.red);
      } else {
        // Handle other errors
        Get.snackbar("Error", e.message ?? "An error occurred",
            // backgroundColor: Colors.red,
            colorText: Colors.red);
      }
    } catch (e) {
      authVM.simple_loading.value = false;
      debugPrint("real error"+ e.toString());
      // Handle any other exceptions
      Get.snackbar("Error", "An unexpected error occurred",
          // backgroundColor: Colors.red,
          colorText: Colors.red);
    }
  }


  // Sign in with Google
  Future<User?> signInWithGoogle() async {

    emailController.clear();
    passwordController.clear();
    setState(() {
      _rememberMe = false;
    });

    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the login
        return null;
      }

      // Obtain the Google authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      print("uid" + user!.uid);

      await _firestore.collection('users').doc(user!.uid).set({
        'name': user.displayName ?? '',
        'email': user.email,
        'bio': '',
        'is_verified': false,
        'phone_number': '',
        'profile_pic': user.photoURL ?? "", // Save the download URL of the profile picture
        'joined': Timestamp.now(),
        'followers': [],
        'following': [],
        'favourites': [],
        'events': [],
        'requested': [],
        'location': '',
        'profile_type': 'Public',
        'uid': user.uid,
      }, SetOptions(merge: true)).then((val){
        debugPrint("user doc created");
      });

      return user;
    } catch (e) {

      print("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> _signInWithGoogle() async {
    authVM.loading.value = true;

    final user = await signInWithGoogle();
    if (user != null) {
      authVM.loading.value = false;
      storage.setItem("logged_in_by", "google");
      print("Signed in as ${user.displayName}");
      Get.offAll(AppNavBar());
    } else {
      authVM.loading.value = false;

      print("Sign-in failed or cancelled");
    }
  }

  // Sign out from Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Check if the user is already signed in
  Future<User?> checkCurrentUser() async {
    final User? user = _auth.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.blueColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 97.71.h),
                Center(
                  child: SizedBox(
                    height: 250.h,
                    width: 250.w,
                    child: Image.asset(
                      "assets/images/qwandery-logo-square-600px-Photoroom.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                CustomText(
                  text: 'Login',
                  fontSize: 35.sp,
                  textColor: AppColors.backgroundColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 6.36.h),
                // Email TextField
                CustomTextField1(
                  hintText: 'Your email',
                  hintTextSize: 14.65.sp,
                  prefixIcon: Icons.email,
                  controller: emailController, // Added controller
                ),
                SizedBox(height: 26.25.h),
                // Password TextField
                CustomTextField1(
                  hintText: 'Your password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  obscuringCharacter: '*',
                  suffixIcon: Icons.visibility,
                  hintTextSize: 14.65.sp,
                  controller: passwordController, // Added controller
                ),
                SizedBox(height: 16.25.h),
                // Remember Me Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: _toggleRememberMe,
                          child: Container(
                            width: 18.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: _rememberMe ? Colors.blue : Colors.white,
                              border: Border.all(
                                color: _rememberMe ? Colors.blue : Colors.grey,
                              ),
                            ),
                            child: _rememberMe
                                ? Icon(
                              Icons.check,
                              size: 12.h,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "Remember information",
                          textColor: Color.fromRGBO(192, 208, 221, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ForgetPasswordEmailPhoneView());
                      },
                      child: CustomText(
                        text: "Forgot password?",
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                // Login Button
                Obx(
                  ()=> CustomButton(
                    loading: authVM.simple_loading.value,
                    text: 'Login',
                    color: AppColors.greenbutton,
                    onPressed: (){
                      if(authVM.loading.value == false){
                        _loginUser();
                      }
                    }, // Call the login method
                  ),
                ),

                SizedBox(height: 50.h),

                GestureDetector(
                  onTap: () {
                    Get.to(() => SignupView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Don’t have an account?',
                        fontSize: 15.sp,
                        textColor: Color.fromRGBO(192, 208, 221, 1),
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        text: ' Sign Up',
                        fontSize: 15.sp,
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                Obx(
                      ()=> CustomButton(
                    loading: authVM.loading.value,
                    text: 'Login via Google',
                    color: AppColors.greenbutton,
                    onPressed: _signInWithGoogle, // Call the login method
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
