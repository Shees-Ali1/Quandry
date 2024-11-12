
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';
import '../const/textstyle.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

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
          ///  Text Interactive Learning Courses & Quizzes.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Discover More CE Opportunities',
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
            height: 31.h,
          ),
          // Text long
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
                'Search & filter conferences, courses, and trainings by available credits, price range, location, topics of interest and more.',
              textAlign: TextAlign.center,
              style: jost500(20.sp, Color.fromRGBO(73, 73, 73, 1)),
              ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.onboardingellipse),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 120.h,
                  ),
                  SizedBox(
                      height: 250.h,
                      width: 321.w,
                      child: Image.asset(
                        AppImages.onboard2,
                        fit: BoxFit.contain,
                      )),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
