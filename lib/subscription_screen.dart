import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:quandry/widgets/custom_text.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppbarSmall(title: 'Subscription Screen'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 46.h),
              // Header Text
              Center(
                child: CustomText(
                  text: 'Get Premium Membership.',
                  textColor: AppColors.blueColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 26.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 22.h),
              // Premium Plan Container with Gradient
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                   color: Color.fromRGBO(25, 72, 95, 1)
                    ,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Premium',
                              textColor: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24.sp,
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.star, color: Colors.white, size: 24),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          text: TextSpan(
                            text: '\$14.99',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '/Month',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          text: 'Get all access of the app without ADS',
                          textColor: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greenbutton,
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          child: CustomText(
                            text: 'UPGRADE',
                            textColor: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // Terms and Conditions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By purchasing, you agree to our ',
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontSize: 14.sp,
                      height: 1.5,
                      fontFamily: 'jost',
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(color: AppColors.greenbutton),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.to(() => TermsAndConditionsScreen());
                          },
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(color: AppColors.greenbutton),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.to(() => PrivacyPolicyScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Free Trial Info Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 28, 49, 1),
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Free Trial Users',
                      textColor: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      text:
                      "Limited access with in app Ads. Upgrade to premium to unlock all features!",
                      textColor: AppColors.backgroundColor,
                      fontSize: 12.sp,
                      textAlign: TextAlign.center, fontWeight: FontWeight.w600,
                    ),
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
