import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({super.key});

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
          ///  Text Latest MedTech Innovations & Updates..
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Latest MedTech Innovations & Updates',
                    style: GoogleFonts.jost(
                      fontSize: 28.sp,
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '.', // The full stop in orange color
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: AppColors.redColor, // Set the color to orange
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
                'This is your MedTech Instagram focusing on showcasing the latest developments in medical technology. keeping users informed with text-based summaries of new devices, innovations, and breakthroughs in biomedical engineering and healthcare technology.',
               ),
          ),
          SizedBox(
            height: 21.9.h,
          ),
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
                    height: 93.h,
                  ),
                  SizedBox(
                      height: 263.h,
                      width: 266.w,
                      child: Image.asset(
                        AppImages.onboard3,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: 50.h,
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
