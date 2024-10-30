import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';

import '../const/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
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
                    height: 133.h,
                    width: 133.w,
                    child: Image.asset("assets/images/qwandery.png"),
                  ),
                ),
                SizedBox(height: 43.64.h),
                Center(
                  child: SizedBox(
                    height: 37.h,
                    width: 296.w,
                    child: Image.asset("assets/images/qwandery_logo.png"),
                  ),
                ),
                SizedBox(height: 43.64.h),

                CustomText(
                  text: 'Login',
                  fontSize: 35.sp,
                  textColor: AppColors.backgroundColor,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 6.36.h),

                /// Your Email Textfield
                Container(
                  width: double.infinity,
                  child: CustomTextField1(
                    hintText: 'Your email',
                    hintTextSize: 14.65.sp,
                    prefixIcon: Icons.email,
                  ),
                ),
                SizedBox(height: 26.25.h),

                /// Your Password Textfield
                Container(
                  width: double.infinity,
                  child: CustomTextField1(
                    hintText: 'Your password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    obscuringCharacter: '*',
                    suffixIcon: Icons.visibility,
                    hintTextSize: 14.65.sp,
                  ),
                ),
                SizedBox(height: 16.25.h),

                /// CheckBox and Remember information Text
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
                        SizedBox(
                            width: 8
                                .w), // Add some space between checkbox and text
                        CustomText(
                          text: "Remember information",
                          textColor: Color.fromRGBO(192, 208, 221, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          //    Get.to(() => ForgetPasswordScreen());
                        },
                        child: CustomText(
                          text: "Forgot password?",
                          textColor: AppColors.redColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),

                /// Login Button
                CustomButton(
                  text: 'Login', color: AppColors.greenbutton, onPressed: () {},

                  // textSize: 19.sp,
                  // height: 51.h,
                  // width: double.infinity,
                  // color: buttonColor,
                  // onTap: () {
                  //   CustomRoute.navigateTo(context, SubscriptionScreen());
                  // },
                  // title: 'Login',
                ),
                SizedBox(height: 100.h),

                GestureDetector(
                  onTap: () {
                    //       CustomRoute.navigateTo(context, SignupView());
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
