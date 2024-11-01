import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/Drawer/online_Support/online_support.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';

import 'privacy_policy_screen/privacy_policy.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blueColor,
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 72.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AppImages.Drawer_logo),
                            fit: BoxFit.cover)),

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
                onTap: () {},
              ),
              DrawerItemsWidget(
                text: 'Calendar',
                image: AppImages.calender_icon,
                onTap: () {},
              ),
              DrawerItemsWidget(
                text: 'Profile',
                image: AppImages.profile_icon,
                onTap: () {},
              ),
              DrawerItemsWidget(
                text: 'Online Support',
                image: AppImages.online_support_icon,
                onTap: () {
                  Get.to(TechnicalSupportChatScreen());
                },
              ),
              DrawerItemsWidget(
                text: 'Terms and conditions',
                image: AppImages.term_condition_icon,
                onTap: () {},
              ),
              DrawerItemsWidget(
                text: 'Privacy Policy',
                image: AppImages.privacy_policy_icon,
                onTap: () {
                  Get.to(PrivacyPolicy());
                },
              ),
              // DrawerItemsWidget(
              //   onTap: () {
              //     showModalBottomSheet(
              //         backgroundColor: Colors.white,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20.r)),
              //         context: context,
              //         builder: (BuildContext context) {
              //           return SizedBox(
              //             height: 290.h,
              //             width: double.infinity,
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 8.h),
              //                 Container(
              //                   width: 48.w,
              //                   height: 5.h,
              //                   decoration: BoxDecoration(color: Color(0xffCDCFD0)),
              //                 ),
              //                 SizedBox(height: 30.h),
              //                 Text(
              //                   "Delete Account",
              //                   style: jost700(24.sp, AppColors.blueColor),
              //                 ),
              //                 SizedBox(height: 8.h),
              //                 Text(
              //                   "Are you sure want to delete this account?",
              //                   style: jost400(16.sp, AppColors.blueColor),
              //                 ),
              //                 SizedBox(height: 37.h),
              //                 SizedBox(height: 22.h),
              //                 GestureDetector(
              //                   onTap: () {
              //                     Get.back();
              //                   },
              //                   child: Text(
              //                     "Cancel",
              //                     style: jost500(16.sp, AppColors.blueColor),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           );
              //         });
              //   },
              //   text: 'Delete Account',
              //   image: AppImages.Bookmark,
              // ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: Row(
                      children: [
                        Container(
                          height: 27.7.h,
                          width: 22.7.w,
                          child: Image.asset(AppImages.logout_icon), // Use Image.asset to display image
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
