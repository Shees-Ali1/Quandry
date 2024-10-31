import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/auth/forgotPassword/forgot_reset.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import '../../controller/selectedtype_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
// import 'package:pinput/pinput.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/forget_back_widget.dart';

class PhoneNumberAuthenticationView extends StatefulWidget {
  const PhoneNumberAuthenticationView({super.key});

  @override
  State<PhoneNumberAuthenticationView> createState() =>
      _PhoneNumberAuthenticationViewState();
}

class _PhoneNumberAuthenticationViewState
    extends State<PhoneNumberAuthenticationView> {
  TextEditingController controller = TextEditingController();
  final selectedTypeController = Get.put(SelectedTypeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close keyboard when tapping outside
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const ForgetPasswordBackWidget(),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Authentication Code",
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 26.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: selectedTypeController.selectedType.value == 'email'
                            ? "Enter 5-digit code for reset password we just\ntexted to your phone number, test@gmail.com"
                            : "Enter 5-digit code for reset password we just\ntexted to your phone number, +1 8976889043",
                        fontSize: 12.sp,
                        textColor: Color(0xff6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      PinCodeTextField(
                        appContext: context,
                        length: 5,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.scale,
                        controller: controller,
                        pinTheme: PinTheme(
                            borderRadius: BorderRadius.circular(11.38.r),
                            borderWidth: 1,
                            activeFillColor: AppColors.blueColor,
                            shape: PinCodeFieldShape.box,
                            activeColor: AppColors.blueColor,
                            selectedColor: AppColors.blueColor,
                            inactiveColor: Color.fromRGBO(238, 239, 242, 1),
                            fieldHeight: 53.h,
                            fieldWidth: 53.w),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: selectedTypeController.selectedType.value == 'email'
                            ? 'Use different email address'
                            : "Use different phone number",
                        fontSize: 15.sp,
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 46.32.h,
                      ),
                      CustomButton(text: 'Continue', color: AppColors.blueColor, onPressed: () {Get.to(()=> ResetPasswordView(email: '', password: ''));  },
                        // height: 51.h,
                        // title: "Continue",
                        // textSize: 19.sp,
                        // onTap: () {
                        //   CustomRoute.navigateTo(
                        //     context,
                        //     const ResetPasswordView(
                        //       email: '',
                        //       password: '',
                        //     ),
                        //   );
                        // },
                      ),
                      SizedBox(
                        height: 12.25.h,
                      ),
                    Container(
                      height: 51.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w,color:  Color.fromRGBO(216, 229, 236, 1)),
                        borderRadius: BorderRadius.circular(13.r)
                      ),
                      child: Center(child: Text("Resend Code",style: jost500(19.sp, AppColors.blueColor),)),
                    )

                        // height: 51,
                        // title: "Resend Code",
                        // textSize: 19.sp,
                        // color: transparentColor,
                        // titleColor: primaryColor,
                        // onTap: () {},

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
