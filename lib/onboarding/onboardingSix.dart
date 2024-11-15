
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/Drawer/privacy_policy_screen/privacy_policy.dart';
import 'package:quandry/Drawer/terms_and_condition/terms_and_condition.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

import '../const/images.dart';
import '../const/textstyle.dart';

class OnBoardingSix extends StatelessWidget {
  const OnBoardingSix({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(viewportFraction: 1);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          ///  Incredible Keyword Search Engine.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Community Guidelines',
                    style: GoogleFonts.jost(
                      fontSize: 24.sp,
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          /// Long Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.2.w),
            child: Text(
              "By using Qwandery, you're agreeing to contribute respectfully and accurately,\nand to avoid submitting false or harmful content.",
              textAlign: TextAlign.center,
              style: jost500(18.sp, Color.fromRGBO(73, 73, 73, 1)),
            ),),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.w),

            child: Text(
              "We aim to provide up-to-date event details, but accuracy cannot be guaranteed.",
              textAlign: TextAlign.center,
              style: jost500(18.sp, Color.fromRGBO(73, 73, 73, 1)),
            ),),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
              "To learn more, please review our",
              textAlign: TextAlign.center,
              style: jost500(15.sp, Color.fromRGBO(73, 73, 73, 1)),
            ),),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(TermsAndConditions());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "Terms of Service",
                textAlign: TextAlign.center,
                style: jost600(
                  20.sp,
                  AppColors.blueColor,
                ).copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.blueColor
                ),
              ),
            ),
          ),

          Text(
            "and",
            textAlign: TextAlign.center,
            style: jost500(17.sp, AppColors.blueColor),
          ),
          GestureDetector(
            onTap: (){
              Get.to(PrivacyPolicy());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                "Privacy Policy",
                textAlign: TextAlign.center,
                style: jost600(
                  20.sp,
                  AppColors.blueColor,
                ).copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.blueColor
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          // Background Blue Circle Image & Center Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(

                      image: AssetImage(AppImages.onboardingellipse,),
                      fit: BoxFit.fill)),

            ),
          )
        ],
      ),
    );
  }
}
