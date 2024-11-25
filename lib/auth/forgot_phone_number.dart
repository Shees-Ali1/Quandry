
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/auth/signup.dart';
import 'package:quandry/const/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/selectedtype_controller.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/forget_back_widget.dart';
import 'forgot_phone_auth.dart';
import 'forgot_reset.dart';


class ForgetPasswordEmailPhoneView extends StatefulWidget {
  const ForgetPasswordEmailPhoneView({super.key});
  @override
  State<ForgetPasswordEmailPhoneView> createState() =>
      _ForgetPasswordEmailPhoneViewState();
}

class _ForgetPasswordEmailPhoneViewState
    extends State<ForgetPasswordEmailPhoneView> {
  final selectedTypeController = Get.put(SelectedTypeController());
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const ForgetPasswordBackWidget(),
                SizedBox(
                  height: 42.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Container(
                      //   height: 38.h,
                      //   decoration: BoxDecoration(
                      //     color: Color(0xffB4C4D1),
                      //     borderRadius: BorderRadius.circular(9.51.r),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //           selectedTypeController
                      //               .changeSelectedType('email');
                      //           setState(() {});
                      //         },
                      //         child: Obx(() => Container(
                      //           margin: const EdgeInsets.only(left: 4.5),
                      //           height: 30.43.h,
                      //           width: 151.w,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(5.71.sp),
                      //               color: selectedTypeController
                      //                   .selectedType.value ==
                      //                   'email'
                      //                   ? AppColors.backgroundColor
                      //                   : AppColors.transparentColor),
                      //           child: Center(
                      //             child: CustomText(
                      //               text: 'Email',
                      //               fontWeight: FontWeight.bold,
                      //               textColor: selectedTypeController
                      //                   .selectedType.value ==
                      //                   'email'
                      //                   ? AppColors.mainTextColor
                      //                   : AppColors.greyColor, fontSize: 12,
                      //             ),
                      //           ),
                      //         )),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           selectedTypeController
                      //               .changeSelectedType('phone');
                      //           setState(() {});
                      //         },
                      //         child: Obx(() => Container(
                      //           margin: const EdgeInsets.only(left: 13),
                      //           height: 30.43.h,
                      //           width: 150.w,
                      //           decoration: BoxDecoration(
                      //               borderRadius:
                      //               BorderRadius.circular(9.51.r),
                      //               color: selectedTypeController
                      //                   .selectedType.value ==
                      //                   'phone'
                      //                   ? AppColors.backgroundColor
                      //                   : AppColors.transparentColor),
                      //           child: Center(
                      //             child: CustomText(
                      //               text: 'Phone',
                      //               fontWeight: FontWeight.bold,
                      //               textColor: selectedTypeController
                      //                   .selectedType.value ==
                      //                   'phone'
                      //                   ? AppColors.mainTextColor
                      //                   : AppColors.greyColor, fontSize: 12,
                      //             ),
                      //           ),
                      //         )),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 32.96.h,
                      // ),
                      Obx(
                            () => CustomText(
                          text:
                          selectedTypeController.selectedType.value == 'email'
                              ? "Enter your email"
                              : "Enter your phone number",
                          fontSize: 24.sp,
                          textColor: AppColors.blueColor,
                          fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Obx(
                            () => CustomText(
                          text: selectedTypeController.selectedType.value ==
                              'email'
                              ? "Please enter a email address to request\na password reset."
                              : "Please enter a phone number to request a password reset.",
                          fontSize: 16.sp,
                       //   maxLines: 2,
                          fontWeight: FontWeight.w500,
                          textColor: Color(0xff6B7280),
                              textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      selectedTypeController.selectedType.value == 'email'
                          ?  Container(
                        width: double.infinity,
                        child: CustomTextField1(
                          hintText: 'Your email',
                          hintTextSize: 15.sp,
                          prefixIcon: Icons.email,
                          borderColor: AppColors.blueColor,
                          borderRadius: 13.sp,
                          fillColor: AppColors.transparentColor,
                        ),
                      )
                          :
                      IntlPhoneField(
                        flagsButtonPadding: EdgeInsets.only(left: 13.w),
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        showDropdownIcon: false,
                        decoration: InputDecoration(
                          hintText: '0000000000',
                          filled: true,
                          fillColor: AppColors.fillcolor,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          counterText: '',
                          hintStyle: TextStyle(
                            color: AppColors.calendartext,
                            fontFamily: 'jost',
                            fontSize: 14.65.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.31.r),
                            borderSide: BorderSide(color: AppColors.textfieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.31.r),
                            borderSide: BorderSide(color: AppColors.textfieldBorder),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13.31.r),
                            borderSide: BorderSide(color: AppColors.textfieldBorder),
                          ),
                        ),
                        initialCountryCode: 'AE',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomButton(
                        text: 'Send',
                        color: AppColors.blueColor,
                        onPressed: () {
                          Get.to(()=>PhoneNumberAuthenticationView());
                        },
                      )
                    ],
                  ),
                ),
                 const Spacer(),
                // SizedBox(
                //   height: 300.25.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don't have an account?",
                      fontSize: 12.sp,
                      textColor: AppColors.blueColor,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        //CustomRoute.navigateTo(context, const SignupView());
                      },
                      child: CustomText(
                        text: "Sign Up",
                        fontSize: 12.sp,
                        textColor: AppColors.redColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            )),
      ),
    );
  }
}
