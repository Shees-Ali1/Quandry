import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';

import '../../const/images.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_email_textfield.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/forget_back_widget.dart';
import 'forgot_phone_auth.dart';


class ResetPasswordView extends StatefulWidget {
  final String? email;
  final String password;

  const ResetPasswordView({super.key, required this.email, required this.password});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final AuthController _authController = Get.put(AuthController());
  bool isChecked = true;
  bool isChecked1 = true;

  final RegExp numberOrSymbolRegExp = RegExp(r'[0-9!@#\$&*~]');
  final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
  final RegExp upperCaseRegExp = RegExp(r'[A-Z]');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                const ForgetPasswordBackWidget(),
                SizedBox(height: 37.82.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Reset Password",
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 26.sp,
                      ),
                      SizedBox(height: 74.18.h),
                      CustomText(
                        text: "New Password",
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp,
                      ),
                      SizedBox(height: 10.h),
                      Form(
                        child: SizedBox(
                          height: 43.75.h,
                          child: EmailCustomTextFiled(
                            readOnly: false,
                            controller: _authController.newPasswordController.value,
                            hintText: '***',
                            hintColor: AppColors.blueColor,
                            hintTextSize: 11.sp,
                            onChange: (v) {
                              _authController.update();
                              _authController.refresh();
                              return null;
                            },
                            prefixIcon: AppImages.password,
                            isBorder: true,
                            isPassword: true,
                            isObscure: isChecked,
                            obscuringCharacter: '*',
                            passwordFunction: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                              return null;
                            },
                            borderRadius: 13.sp,
                            fillColor: AppColors.transparentColor,
                            beforePasswordIcon: Icons.visibility_off_outlined,
                            afterPasswordIcon: Icons.visibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.25.h),
                      GetBuilder<AuthController>(builder: (_authController) {
                        bool containsNumberOrSymbol =
                        numberOrSymbolRegExp.hasMatch(
                            _authController.newPasswordController.value.text);
                        bool containsLowerCase = lowerCaseRegExp.hasMatch(
                            _authController.newPasswordController.value.text);
                        bool containsUpperCase = upperCaseRegExp.hasMatch(
                            _authController.newPasswordController.value.text);
                        bool containsBoth =
                            containsLowerCase && containsUpperCase;
                        double checks = (containsNumberOrSymbol ? 0.5 : 0) +
                            (containsLowerCase ? 0.5 : 0) +
                            (containsUpperCase ? 0.5 : 0) +
                            (_authController.newPasswordController.value.length >= 8
                                ? 2
                                : 0);

                        double password_strength = (checks / 4);
                        return LinearProgressIndicator(
                          value: password_strength,
                          backgroundColor: Colors.grey[300],
                          minHeight: 5,
                          color: password_strength <= 1 / 4
                              ? Colors.red
                              : password_strength == 2 / 4
                              ? Colors.yellow
                              : password_strength == 3 / 4
                              ? Colors.blue
                              : Colors.green,
                        );
                      }),
                      SizedBox(height: 12.25.h),
                      GetBuilder<AuthController>(builder: (_authController) {
                        bool containsLowerCase = lowerCaseRegExp.hasMatch(
                            _authController.newPasswordController.value.text);
                        bool containsUpperCase = upperCaseRegExp.hasMatch(
                            _authController.newPasswordController.value.text);
                        bool containsBoth =
                            containsLowerCase && containsUpperCase;
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _authController.newPasswordController.value.length >= 8
                                    ? Image.asset(
                                  AppImages.tickIcon,
                                  height: 9.6.h,
                                  width: 13.w,
                                  color: AppColors.blueColor,
                                )
                                    : const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: AppColors.blueColor,
                                ),
                                SizedBox(width: 6.w),
                                CustomText(
                                  text: "Least 8 characters".tr,
                                  fontSize: 12.25.sp,
                                  textColor: _authController.newPasswordController.value.length >= 8
                                      ? AppColors.blueColor
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                numberOrSymbolRegExp.hasMatch(
                                    _authController.newPasswordController.value.text)
                                    ? Image.asset(
                                  AppImages.tickIcon,
                                  height: 9.6.h,
                                  width: 13.w,
                                  color: AppColors.blueColor,
                                )
                                    : const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: AppColors.blueColor,
                                ),
                                SizedBox(width: 6.w),
                                CustomText(
                                  text: "Least one number (0-9) or symbol".tr,
                                  fontSize: 12.25.sp,
                                  textColor: numberOrSymbolRegExp.hasMatch(
                                      _authController.newPasswordController.value.text)
                                      ? AppColors.blueColor
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                containsBoth
                                    ? Image.asset(
                                  AppImages.tickIcon,
                                  height: 9.6.h,
                                  width: 13.w,
                                  color: AppColors.blueColor,
                                )
                                    : const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: AppColors.blueColor,
                                ),
                                SizedBox(width: 6.w),
                                CustomText(
                                  text: "Lowercase (a-z) and uppercase (A-Z)".tr,
                                  fontSize: 12.25.sp,
                                  textColor: containsBoth ? AppColors.blueColor : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 25.34.h),
                      CustomText(
                        text: "Confirm Password",
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 43.75.h,
                        child: EmailCustomTextFiled(
                          readOnly: false,
                          controller: _authController.confirmPasswordController.value,
                          hintText: '***',
                          hintColor: AppColors.blueColor,
                          hintTextSize: 11.sp,
                          prefixIcon: AppImages.password,
                          isBorder: true,
                          isPassword: true,
                          obscuringCharacter: '*',
                          isObscure: isChecked1,
                          passwordFunction: () {
                            setState(() {
                              isChecked1 = !isChecked1;
                            });
                            return null;
                          },
                          borderRadius: 13.sp,
                          fillColor:AppColors.transparentColor,
                          beforePasswordIcon: Icons.visibility_off_outlined,
                          afterPasswordIcon: Icons.visibility,
                        ),
                      ),
                      SizedBox(height: 42.25.h),
                      CustomButton(text: 'Reset Password', color: AppColors.blueColor, onPressed: () { },
                        // height: 51.h,
                        // title: "Reset Password",
                        // textSize: 19.sp,
                        // onTap: () {
                        //   if (_authController.newPasswordController.value.text ==
                        //       _authController.confirmPasswordController.value.text) {
                        //     CustomRoute1.navigateAndRemoveUntil(
                        //         context,
                        //         const LoginView(),
                        //             (route) => false);
                        //   } else {
                        //     Get.snackbar("Error", "Passwords do not match",
                        //         colorText: Colors.white);
                        //   }
                        // },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// part of '../pinput.dart';

extension PinputControllerExt on TextEditingController {
  /// The length of the Pinput value
  int get length => this.text.length;

  /// Sets Pinput value
  void setText(String pin) {
    this.text = pin;
  }}