import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quandry/const/colors.dart';
import 'dart:io';

import '../const/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';


class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isChecked = false;
  File? _image; // Variable to store the selected image

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
          backgroundColor: AppColors.backgroundColor, // Change this to your desired color
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
                        image: AssetImage("assets/images/signup_eclipse.png"), fit: BoxFit.fill)),
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    SizedBox(
                      height: 83.h,
                      width: 83.w,
                      child: Image.asset(
                        "assets/images/qwandery.png",
                      ),
                    ),
                    SizedBox(height: 23.h,),
                    SizedBox(
                      height: 23.h,
                      width: 186.w,
                      child: Image.asset(
                        "assets/images/qwandery_logo.png",
                      ),
                    ),
                    SizedBox(height: 43.h,),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(

                        text: 'Sign up ',

                        textColor: AppColors.backgroundColor,
                        fontWeight: FontWeight.w700, fontSize: 35.sp,
                      ),
                    ),
                    SizedBox(height: 34.h,),

                    /// Image Upload
                    GestureDetector(
                      onTap: () => _showImageSourceDialog(context), // Open image picker on tap
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
              // Remaining code...
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
                child: Column(
                  children: [
                    Container(
                      width: 311.w,
                      child: CustomTextField1(
                        hintText: 'Your name',
                        prefixIcon: Icons.person,
                        hintTextSize: 14.65.sp,
                        obscuringCharacter: null,
                      ),
                    ),
                    SizedBox(height: 16.25.h),
                    Container(
                      width: 311.w,
                      child: CustomTextField1(
                        hintText: 'Your Email',
                        hintTextSize: 14.65.sp,
                        prefixIcon: Icons.email,
                      ),
                    ),
                    SizedBox(height: 14.25.h),
                    Container(
                      width: 311.w,
                      child: CustomTextField1(
                        hintText: 'Your Password',
                        prefixIcon: Icons.lock,
                        obscureText: true,
                        obscuringCharacter: '*',
                        suffixIcon: Icons.visibility,
                        hintTextSize: 14.65.sp,
                      ),
                    ),
                    SizedBox(height: 24.25.h),
                    /// Continue Button
                    CustomButton(
                      color: AppColors.greenbutton,
                      text:"Continue" ,
                      onPressed: (){},

                    ),
                    SizedBox(height: 14.25.h),
                    /// Text Span
                    Center(
                      child: SizedBox(
                        width: 307.w, // Adjust this width as needed
                        child: RichText(
                          textAlign: TextAlign.center, // Align text in the center
                          text: TextSpan(
                            text: 'By signing up you agree to our ',
                            style: TextStyle(
                              color: Color.fromRGBO(17, 24, 39, 1),


                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.5.h,
                              fontFamily: 'jost',
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Services',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5.h,
                                  fontFamily: 'jost',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Terms of Service
                                  },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: Color.fromRGBO(17, 24, 39, 1),
                                  height: 1.5.h,
                                  fontFamily: 'jost',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5.h,
                                  fontFamily: 'jost',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //   Get.to(() => PrivacyPolicy());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                    /// Already have an Account
                    GestureDetector(
                      onTap: () {
                        //    CustomRoute.navigateTo(context, LoginView());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Already have an account? ',
                            fontSize: 15.sp,
                            textColor: Color(0xff111827),
                            fontWeight: FontWeight.w300,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Sign in',

                            textColor: AppColors.redColor,
                            fontWeight: FontWeight.w500, fontSize: 15.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),
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
