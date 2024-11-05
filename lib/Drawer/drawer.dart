import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/Drawer/online_Support/online_support.dart';
import 'package:quandry/auth/login.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';

import '../bottom_nav/bottom_nav.dart';
import 'privacy_policy_screen/privacy_policy.dart';
import 'terms_and_condition/terms_and_condition.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blueColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 72.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppImages.Drawer_logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 9.8.w),
                  Text(
                    "QWANDERY",
                    style: jost600(20.sp, AppColors.backgroundColor),
                  ),
                ],
              ),
              SizedBox(height: 64.h),
              DrawerItemsWidget(
                text: 'Home',
                image: AppImages.home_icon,
                onTap: () {
                  Navigator.pop(context); // Close the drawer first
                  final navBarState = context.findAncestorStateOfType<AppNavBarState>();
                  navBarState?.navigateToPage(0); // Navigate to Home
                },
              ),
              DrawerItemsWidget(
                text: 'Calendar',
                image: AppImages.calender_icon,
                onTap: () {
                  Navigator.pop(context);
                  final navBarState = context.findAncestorStateOfType<AppNavBarState>();
                  navBarState?.navigateToPage(2); // Navigate to Calendar
                },
              ),
              DrawerItemsWidget(
                text: 'Profile',
                image: AppImages.profile_icon,
                onTap: () {
                  Navigator.pop(context);
                  final navBarState = context.findAncestorStateOfType<AppNavBarState>();
                  navBarState?.navigateToPage(3); // Navigate to Profile
                },
              ),

              DrawerItemsWidget(
                text: 'Online Support',
                image: AppImages.online_support_icon,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(TechnicalSupportChatScreen());
                },
              ),
              DrawerItemsWidget(
                text: 'Terms and conditions',
                image: AppImages.term_condition_icon,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(TermsAndConditions());
                },
              ),
              DrawerItemsWidget(
                text: 'Privacy Policy',
                image: AppImages.privacy_policy_icon,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(PrivacyPolicy());
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: ()  {
                      Get.offAll(LoginView()); // Clears the entire navigation stack
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 27.7.h,
                          width: 22.7.w,
                          child: Image.asset(AppImages.logout_icon),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          "Logout",
                          style: jost500(15.sp, AppColors.backgroundColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class DrawerItemsWidget extends StatelessWidget {
  final String text;
  final String image;
  final void Function()? onTap;

  const DrawerItemsWidget(
      {super.key, required this.text, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric( vertical: 15.h),
        child: Row(
          children: [
            Container(
              height: 21.7.h,
              width: 21.7.w,
              child: Image.asset(image), // Use Image.asset to display image
            ),
            SizedBox(width: 24.32.w),
            Text(
              text,
              style: jost500(15.sp, AppColors.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
