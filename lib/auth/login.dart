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
      authVM.loading.value = true;

      // Attempt to sign in the user with Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      authVM.loading.value = false;

      if (_rememberMe) {
        storage.setItem('email', email);
        storage.setItem('password', password);
      } else {
        storage.removeItem('email');
        storage.removeItem('password');
      }

      // If successful, navigate to the AppNavBar
      Get.to(() => AppNavBar());
    } on FirebaseAuthException catch (e) {
      authVM.loading.value = false;

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
      authVM.loading.value = false;
      debugPrint("real error"+ e.toString());
      // Handle any other exceptions
      Get.snackbar("Error", "An unexpected error occurred",
          // backgroundColor: Colors.red,
          colorText: Colors.red);
    }
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
                    loading: authVM.loading.value,
                    text: 'Login',
                    color: AppColors.greenbutton,
                    onPressed: _loginUser, // Call the login method
                  ),
                ),
                SizedBox(height: 100.h),
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
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
