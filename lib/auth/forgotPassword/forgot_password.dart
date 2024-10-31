import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';

import '../../const/images.dart';
import '../../controller/selectedtype_controller.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/forget_back_widget.dart';
import '../signup.dart';
import 'forgot_phone_number.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final selectedTypeController = Get.put(SelectedTypeController());
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  int tappedContainerIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          const ForgetPasswordBackWidget(),
          SizedBox(height: 25.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Forgot password?",
                  fontSize: 24.sp,
                  textColor: AppColors.blueColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  text: "Please choose a method to request a \npassword reset.",
                  textAlign: TextAlign.start,
                  textColor: const Color(0xff6B7280),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () {
               Get.to(()=>ForgetPasswordEmailPhoneView());

                    setState(() {
                      tappedContainerIndex = 1;
                      selectedTypeController.changeSelectedType('email');
                    });
                  },
                  child: Container(
                    height: 73.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: tappedContainerIndex == 1
                                ? AppColors.greyColor
                                : Color.fromRGBO(205, 211, 214, 1)

                        ),
                        color: tappedContainerIndex == 1
                            ?   Color.fromRGBO(180, 196, 209, 1)

                            : AppColors.fillcolor,

                        //Color(0xffF9FAFB),

                        borderRadius: BorderRadius.circular(11.38.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.7.w),
                          child: Row(
                            children: [
                              Container(
                                  height: 38.h,
                                  width: 38.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Image.asset(AppImages.email,
                                      color: tappedContainerIndex == 1
                                          ? AppColors.greenbutton
                                          : const Color(0xff9CA3AF),
                                      scale: 2.2)),
                              SizedBox(
                                width: 15.7.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Your email",
                                    fontSize: 13.27.sp,
                                    textColor: const Color(0xff111827),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "Enter your email",
                                    fontSize: 11.38.sp,
                                    textColor: const Color(0xff6B7280),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 17,
                                color: Color(0xff6B7280),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 11.38.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>ForgetPasswordEmailPhoneView());
                    setState(() {
                      tappedContainerIndex = 2;
                      selectedTypeController.changeSelectedType('phone');
                    });
                  },
                  child: Container(
                    height: 73.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: tappedContainerIndex == 2
                                ? AppColors.greyColor
                                : Color.fromRGBO(205, 211, 214, 1)

                        ),
                        color: tappedContainerIndex == 2
                            ?   Color.fromRGBO(180, 196, 209, 1)

                            : AppColors.fillcolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.7.w),
                          child: Row(
                            children: [
                              Container(
                                  height: 38.h,
                                  width: 38.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Image.asset(
                                    // fit: BoxFit.fill,
                                    AppImages.phone,
                                    color: tappedContainerIndex == 2
                                        ? AppColors.greenbutton
                                        : const Color(0xff9CA3AF),
                                    scale: 2.6,
                                  )),
                              SizedBox(
                                width: 15.17.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Phone number",
                                    fontSize: 13.27.sp,
                                    textColor: const Color(0xff111827),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "Enter your phone number",
                                    fontSize: 11.38.sp,
                                    textColor: const Color(0xff6B7280),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 17,
                                color: Color(0xff6B7280),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have an account?",
                  textColor: AppColors.blueColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: "Sign Up",
                  textColor: AppColors.redColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      )),
    );
  }
}
