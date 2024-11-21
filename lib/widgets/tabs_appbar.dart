import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/profile_screen/user_profile.dart';
import 'package:quandry/setting_screen/notification_screens/notification_screen_main.dart';
import 'package:quandry/setting_screen/notification_setting/notification_setting.dart';
import 'package:get/get.dart';

import '../Homepage/filter_home.dart';
import '../bottom_nav/bottom_nav.dart';

class TabsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileController profileVM = Get.put(ProfileController());



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(height: 48.86.h), // Top padding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Search field
                Container(
                  height: 38.h,
                  width: 256.w,
                  child: TextField(
                    style: TextStyle(color: AppColors.appbartextColor),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                      hintText: 'Search for anything',
                      hintStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14.36.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 19.2.h,
                          width: 19.2.w,
                          child: Image.asset(
                            AppImages.search_icon,
                            color: AppColors.backgroundColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                          ),
                          isScrollControlled: true,
                          builder: (_) => FilterContent(),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w,top: 5.h,bottom: 5.h,left: 7.w),
                          child: Container(
                            width: 8.w,
                            decoration: BoxDecoration(
                              color: AppColors.free,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.filter,
                                  color: AppColors.blueColor,
                                  height: 13.h,
                                  width: 13.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(50, 82, 98, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    /// notification Button
                    GestureDetector(
                      onTap:(){ Get.to(NotificationScreenMain());},
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: Image.asset(
                          AppImages.notification_icon_small,
                          height: 25.h,
                          width: 25.w,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w), // Top padding

                    GestureDetector(
                      onTap: (){
                        final navBarState = context.findAncestorStateOfType<AppNavBarState>();
                        navBarState?.navigateToPage(2);
                      },
                      child: Obx(
                        ()=> CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.greenbutton,
                          backgroundImage: profileVM.profilePicture.value != "" ? NetworkImage(profileVM.profilePicture.value) : null,
                          child: profileVM.profilePicture.value != "" ? SizedBox() : Icon(Icons.person, size: 25.w, color: AppColors.primaryColor,),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
