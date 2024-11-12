import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';
import '../const/textstyle.dart';

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
                    text: 'Save Events & Track Your Progress',
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
            height: 40.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
                'Bookmark your favorite events and keep track of your attended, upcoming, and favorite events—all in one convenient place.',
              textAlign: TextAlign.center,
              style: jost500(20.sp, Color.fromRGBO(73, 73, 73, 1)),
               ),
          ),
          SizedBox(
            height: 33.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.onboardingellipse),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(left: 40.w),
                    child: Image.asset(
                      AppImages.onboard3,
                      height: 290.h,


                    ),
                  ),
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
