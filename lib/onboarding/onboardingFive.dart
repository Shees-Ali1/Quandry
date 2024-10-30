
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';
import '../const/textstyle.dart';

class OnBoardingFive extends StatelessWidget {
  const OnBoardingFive({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Go Ad-Free with Premium',
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
            height: 32.9.h,
          ),
          /// Long Text
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
                "Upgrade to remove ads and enjoy a seamless experience for a small yearly fee.",
              textAlign: TextAlign.center,
              style: jost500(20.sp, Color.fromRGBO(73, 73, 73, 1)),
          ),),
          SizedBox(
            height: 32.9.h,
          ),
          // Background Blue Circle Image & Center Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.onboardingellipse),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 89.h,
                  ),
                  SizedBox(
                      height: 267.h,
                      width: 222.w,
                      child: Image.asset(
                        AppImages.onboard5,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: 33.h,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
