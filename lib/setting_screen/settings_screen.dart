import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/profile_screen/profile_screen_main.dart';
import 'package:quandry/setting_screen/change_language_screen/select_language_screen.dart';
import 'package:quandry/setting_screen/change_password/change_password.dart';
import 'package:quandry/setting_screen/notification_screens/notification_screen_main.dart';
import 'package:quandry/setting_screen/notification_setting/notification_setting.dart';
import 'package:quandry/widgets/appbar_small.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(
        key: _scaffoldKey, // Assign the scaffold key
        appBar: AppbarSmall(
          title: "Settings", // Set the title for the app bar
          iconImage: AppImages.drawer_icon, // Set your custom back icon
          onIconTap: () {
            _scaffoldKey.currentState?.openDrawer(); // Open drawer on icon tap
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        drawer: MyDrawer(), // Your custom drawer widget
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              children: [
                SizedBox(height: 44.h),
                /// Profile Image
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 138.w,
                    child: SizedBox(
                      height: 126.h,
                      width: 126.w,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppImages.profile_pic),
                        radius: 50, // Optional: customize radius if needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                /// Profile Name
                Text("Muhammad Ali", style: jost700(16.sp, AppColors.blueColor)),
                SizedBox(height: 1.h),
                Text("test@gmail.com", style: jost400(16.sp, AppColors.blueColor)),
                SizedBox(height: 7.h),
                /// Edit Button
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileScreenMain());
                  },
                  child: Container(
                    height: 35.h,
                    width: 56.25.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.96.r),
                      color: AppColors.bluegrey,
                    ),
                    child: Center(
                      child: Text("Edit", style: jost700(13.sp, AppColors.blueColor)),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                /// Change Password Button
                GestureDetector(
                  onTap: () {
                    Get.to(ChangePassword());
                  },
                  child: Container(
                    height: 61.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.31.r),
                      color: AppColors.fillcolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: jost600(16.sp, AppColors.blueColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blueColor, // Customize the icon color if needed
                            size: 16.sp, // Customize the icon size
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                /// Notifications Button
                GestureDetector(
                  onTap: () {
                    Get.to(NotificationScreenMain());
                  },
                  child: Container(
                    height: 61.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.31.r),
                      color: AppColors.fillcolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications",
                            style: jost600(16.sp, AppColors.blueColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blueColor, // Customize the icon color if needed
                            size: 16.sp, // Customize the icon size
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                /// Notifications Settings
                GestureDetector(
                  onTap: () {
                    Get.to(NotificationSetting());
                  },
                  child: Container(
                    height: 61.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.31.r),
                      color: AppColors.fillcolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications Settings",
                            style: jost600(16.sp, AppColors.blueColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blueColor, // Customize the icon color if needed
                            size: 16.sp, // Customize the icon size
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                /// Change Language Button
                GestureDetector(
                  onTap: () {
                    Get.to(SelectLanguageScreen());
                  },
                  child: Container(
                    height: 61.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.31.r),
                      color: AppColors.fillcolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Language",
                            style: jost600(16.sp, AppColors.blueColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blueColor, // Customize the icon color if needed
                            size: 16.sp, // Customize the icon size
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
