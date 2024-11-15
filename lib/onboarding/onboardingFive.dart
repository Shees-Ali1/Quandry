
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Join our Pro Network to Eliminate Ads',
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
            height: 42.h,
          ),
          /// Long Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
                "For a small annual fee, upgrade to enjoy an ad-free experience, and stand out as a verified professional.",
              textAlign: TextAlign.center,
              style: jost500(20.sp, Color.fromRGBO(73, 73, 73, 1)),
          ),),
          SizedBox(
            height: 25.h,
          ),
          // Background Blue Circle Image & Center Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(

                      image: AssetImage(AppImages.onboardingellipse,),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                      height: 376.h,
                      width: 254.w,
                      child: Image.asset(
                        'assets/images/Premium.png',
                        // AppImages.onboard5,
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
