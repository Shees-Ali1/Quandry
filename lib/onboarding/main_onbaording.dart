import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboardThree.dart';
import 'onboardingFive.dart';
import 'onboardingFour.dart';
import 'onboardingOne.dart';
import 'onboardingTwo.dart';

class MainOnBoardingView extends StatefulWidget {
  const MainOnBoardingView({super.key});

  @override
  State<MainOnBoardingView> createState() => _MainOnBoardingViewState();
}

class _MainOnBoardingViewState extends State<MainOnBoardingView> {
  PageController pageController = PageController();
  int currentpage = 0;

  void _moveToNextPage() {
    // Check if there is a next page
    if (currentpage < 4) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (currentpage == 4) {
      Get.offAll(AppNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentpage + 1) / 5;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // PageView with disabled scroll
          PageView(
            //physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentpage = index;
              });
            },
            children: const [
              OnBoardingOne(),
              OnBoardingTwo(),
              OnBoardingThree(),
              OnBoardingFour(),
              OnBoardingFive(),
            ],
          ),

          // Positioned navigation controls (progress indicator and arrow button)
          Container(
            alignment: const Alignment(0, 0.92),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotWidth: 9.w,
                      dotHeight: 9.h,
                      activeDotColor: AppColors.redColor,
                      dotColor: Colors.white,
                    ),
                    controller: pageController,
                    count: 5,
                  ),

                  // Arrow button with circular progress
                  GestureDetector(
                    onTap: () {
                      _moveToNextPage();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.redColor, // Button color
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          height: 65,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 1.5,
                            backgroundColor:
                                AppColors.redColor.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.redColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
