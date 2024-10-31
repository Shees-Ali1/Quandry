import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';




class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 32.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 28.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:AssetImage(AppImages.profile_pic),
                          fit: BoxFit.cover)),
                  height: 76.h,
                  width: 76.w,
                ),

                Container(
                    width: 140.w,
                    child: Text("Hello",
                      style: jost400(20.sp, AppColors.blueColor),
                    ),

                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            DrawerItemsWidget(
              text: 'Home',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, const MainEditProfileView());
              },
            ),
            DrawerItemsWidget(
              text: 'Calendar',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, const MainPrivacypolicyView());
              },
            ),
            DrawerItemsWidget(
              text: 'Profile',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, const MainTermCondView());
              },
            ),

            DrawerItemsWidget(
              text: 'Online Support',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, EmailSender());
              },
            ),
            DrawerItemsWidget(
              text: 'Terms and conditions',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, EmailSender());
              },
            ),
            DrawerItemsWidget(
              text: 'Privacy Policy',
              image: AppImages.Bookmark,
              onTap: () {
                // CustomRoute.navigateTo(context, EmailSender());
              },
            ),
            DrawerItemsWidget(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 290.h,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              width: 48.w,
                              height: 5.h,
                              decoration:
                              const BoxDecoration(color: Color(0xffCDCFD0)),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text("Delete Account",
                              style: jost700(24.sp, AppColors.blueColor),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),

                            Text("Are you sure want to delete this account?",
                              style: jost400(16.sp, AppColors.blueColor),
                            ),
                            SizedBox(
                              height: 37.h,
                            ),

                            SizedBox(
                              height: 22.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text("Cancel",
                                style: jost500(16.sp, AppColors.blueColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              text: 'Delete Account',
              image: AppImages.Bookmark,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    // await loginAuthController.logOut();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text("Log Out",
                        style: jost700(16.sp, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                )
              ],
            ),
            const Spacer(),
          ],
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        child: Row(
          children: [
            Container(
              height: 21.7.h,
              width: 21.7.w,
             color: Colors.yellow,
            ),
            SizedBox(
              width: 24.32.w,
            ),
            Container(
              width: 160,
              child: Text(text,
                style: jost500(15.sp, AppColors.blueColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
