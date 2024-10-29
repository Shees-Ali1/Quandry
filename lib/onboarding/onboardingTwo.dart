
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quandry/const/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const/images.dart';

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
                    text: 'Interactive Learning Courses & Quizzes',
                    style: GoogleFonts.jost(
                      fontSize: 28.sp,
                      color: AppColors.redColor,
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
            height: 10.h,
          ),
          /// Text long
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),

            child: Text(
                'Thorough, text-based learning modules that dive into critical areas of biomedical engineering, breaking down complex topics into readable, easy-to-understand sections, coupled with a variety of interactive quizez to test your knowledge and skills gained in a certain area.',
              ),
          ),
          SizedBox(
            height: 13.h,
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
                    height: 67.h,
                  ),
                  SizedBox(
                      height: 274.h,
                      width: 309.w,
                      child: Image.asset(
                        AppImages.onboard2,
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
