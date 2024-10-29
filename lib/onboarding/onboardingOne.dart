
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({super.key});

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
          /// Text The best Medical Device Library in the world.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Discover the Best CE Events',
                    style: GoogleFonts.jost(
                      fontSize: 24.sp,
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '.', // The full stop in orange color
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.black, // Set the color to orange
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 19.81.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              'A detailed and organized repository of medical devices, offering comprehensive information on how each device works, its importance, and its clinical applications, making it an essential reference for biomedical engineers and healthcare professionals.',

            ),
          ),
          SizedBox(
            height: 17.19.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.onboardingellipse,),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 93.h,
                  ),
                  SizedBox(
                    height: 236.h,
                    width: 264.w,
                    child: Image.asset(
                      AppImages.onboard1,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
