import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quandry/controller/auth_controller.dart';
import 'dart:io';

import '../const/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';
import 'login.dart'; // Make sure to import the LoginView

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController authVM = Get.find<AuthController>();
  bool isChecked = false;
  File? _image; // Variable to store the selected image

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance; // Firebase Storage instance

  // Controllers for user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to register the user
  Future<void> _registerUser() async {

    authVM.loading.value = true;

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a profile picture.')),
      );
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get the created user
      User? user = userCredential.user;

      if (user != null) {
        // Upload the image to Firebase Storage
        String fileName = 'profile_pictures/${user.uid}.jpg';
        UploadTask uploadTask = _storage.ref(fileName).putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Store user details in Firestore under the user's UID
        await _firestore.collection('users').doc(user.uid).set({
          'name': _nameController.text.trim(),
          'email': user.email,
          'bio': '',
          'is_verified': false,
          'phone_number': '',
          'profile_pic': downloadUrl, // Save the download URL of the profile picture
          'joined': Timestamp.now(),
          'followers': [],
          'following': [],
          'favourites': [],
          'events': [],
          'requested': [],
          'location': '',
          'profile_type': 'Public',
          'is_blocked': false,
          'chat_blocked': false,
          "is_deleted": false,
          "created_by": "Self",
          'uid': user.uid,
        });

        // Update the password for the current user
        await user.updatePassword(_passwordController.text.trim());
        authVM.loading.value = false;

        // Navigate to the LoginView screen after successful registration
        Get.offAll(() => LoginView()); // Use Get.offAll to replace the current screen with LoginView
      }
    } catch (e) {
      authVM.loading.value = false;
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> createAdmin() async {

    authVM.loading.value = true;

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a profile picture.')),
      );
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get the created user
      User? user = userCredential.user;

      if (user != null) {
        // Upload the image to Firebase Storage
        String fileName = 'profile_pictures/${user.uid}.jpg';
        UploadTask uploadTask = _storage.ref(fileName).putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Store user details in Firestore under the user's UID
        await _firestore.collection('admin').doc(user.uid).set({
          'name': _nameController.text.trim(),
          'email': user.email,
          'bio': '',
          'is_verified': false,
          'phone_number': '',
          'profile_pic': downloadUrl, // Save the download URL of the profile picture
          'joined': Timestamp.now(),
          'followers': [],
          'following': [],
          'favourites': [],
          'events': [],
          'requested': [],
          'location': '',
          'profile_type': 'Public',
          'uid': user.uid,
        });

        // Update the password for the current user
        await user.updatePassword(_passwordController.text.trim());
        authVM.loading.value = false;

        // Navigate to the LoginView screen after successful registration
        Get.offAll(() => LoginView()); // Use Get.offAll to replace the current screen with LoginView
      }
    } catch (e) {
      authVM.loading.value = false;
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to take a photo using the camera
  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to show a dialog for choosing image source
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            text: 'Choose an Option',
            textColor: AppColors.redColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(); // Pick image from gallery
                },
                child: CustomText(
                  text: 'Gallery',
                  textColor: AppColors.blueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _takePhoto(); // Take photo with camera
                },
                child: CustomText(
                  text: 'Camera',
                  textColor: AppColors.blueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.backgroundColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/signup_eclipse.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    SizedBox(
                      height: 83.h,
                      width: 83.w,
                      child: Image.asset("assets/images/qwandery.png"),
                    ),
                    SizedBox(height: 23.h),
                    SizedBox(
                      height: 23.h,
                      width: 186.w,
                      child: Image.asset("assets/images/qwandery_logo.png"),
                    ),
                    SizedBox(height: 30.h),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: 'Sign up',
                        textColor: AppColors.backgroundColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 35.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Image Upload
                    GestureDetector(
                      onTap: () => _showImageSourceDialog(context),
                      child: Container(
                        height: 106.h,
                        width: 106.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: _image == null
                            ? Image.asset('assets/images/upload.png', fit: BoxFit.contain)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                child: Column(
                  children: [
                    CustomTextField1(
                      controller: _nameController,
                      hintText: 'Your name',
                      prefixIcon: Icons.person,
                      hintTextSize: 14.65.sp,
                      borderColor: AppColors.textfieldBorder,
                      borderWidth: 1.w,
                    ),
                    SizedBox(height: 16.25.h),
                    CustomTextField1(
                      controller: _emailController,
                      hintText: 'Your email',
                      hintTextSize: 14.65.sp,
                      prefixIcon: Icons.email,
                      borderColor: AppColors.textfieldBorder,
                      borderWidth: 1.w,
                    ),
                    SizedBox(height: 14.25.h),
                    CustomTextField1(
                      controller: _passwordController,
                      borderColor: AppColors.textfieldBorder,
                      borderWidth: 1.w,
                      hintText: 'Your password',
                      prefixIcon: FontAwesomeIcons.lock,
                      obscureText: true,
                      obscuringCharacter: '*',
                      suffixIcon: Icons.visibility,
                      hintTextSize: 14.65.sp,
                    ),
                    SizedBox(height: 24.25.h),

                    // Continue Button
                    Obx(
                      ()=> CustomButton(
                        loading: authVM.loading.value,
                        color: AppColors.greenbutton,
                        text: "Continue",
                        onPressed: _registerUser, // Call _registerUser on press
                      ),
                    ),
                    SizedBox(height: 14.25.h),

                    // Terms and Conditions
                    Center(
                      child: SizedBox(
                        width: 307.w,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By signing up, you agree to our ',
                            style: TextStyle(
                              fontSize: 12.8.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5.h,
                                  fontFamily: 'jost',
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigate to Terms & Conditions
                                },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5.h,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5.h,
                                  fontFamily: 'jost',
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigate to Privacy Policy
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
