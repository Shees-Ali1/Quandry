import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/Drawer/online_Support/online_support.dart';
import 'package:quandry/Drawer/privacy_policy_screen/privacy_policy.dart';
import 'package:quandry/Drawer/terms_and_condition/terms_and_condition.dart';
import 'package:quandry/auth/login.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/profile_screen/profile_screen_main.dart';
import 'package:quandry/profile_screen/user_profile.dart';
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
  bool isProfilePrivate = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h), // Set the height of the custom app bar
          child: AppBar(
            automaticallyImplyLeading: false, // Remove the default back arrow
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: () {
                       Get.to(NotificationScreenMain());
                      },
                      child: Image.asset(
                      'assets/images/notification_icon_small.png',
                         height: 28.h,
                         width: 28.w,
                      ),
                    ),
                  ),
                  // Spacer to push the title to the center
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Settings',
                          style: jost700(16.sp, Colors.white), // Custom font style
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 63.w), // Adjust width to balance layout symmetry
                ],
              ),
            ),
          ),
        ),

        backgroundColor: AppColors.backgroundColor,

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                /// Profile Image
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 138.w,
                    child: SizedBox(
                      height: 126.h,
                      width: 126.w,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(AppImages.profile_pic),
                        radius: 50,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile: ${isProfilePrivate ? "Private" : "Active"}',
                      style: jost600(16.sp, AppColors.blueColor),
                    ),
                    Switch(
                      value: isProfilePrivate,
                      activeColor: AppColors.blueColor,
                      onChanged: (value) {
                        setState(() {
                          isProfilePrivate = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                // GestureDetector(
                //   onTap: () {
                //     Get.to(UserProfilePage());
                //   },
                //   child: Container(
                //     height: 61.h,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(13.31.r),
                //       color: AppColors.fillcolor,
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 18.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             "My Profile",
                //             style: jost600(16.sp, AppColors.blueColor),
                //           ),
                //           Icon(
                //             Icons.arrow_forward_ios,
                //             color: AppColors.blueColor, // Customize the icon color if needed
                //             size: 16.sp, // Customize the icon size
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 14.h),
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
                /// online Settings
                GestureDetector(
                  onTap: () {
                    Get.to(TechnicalSupportChatScreen());
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
                            "Online Support",
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

                /// privacy Settings
                GestureDetector(
                  onTap: () {
                    Get.to(TermsAndConditions());
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
                            "Terms and conditions",
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
                    Get.to(PrivacyPolicy());
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
                            "Privacy Policy",
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

                SizedBox(height: 30.h),

                /// Sign Out Button
                GestureDetector(
                  onTap: () {
                    Get.offAll(LoginView());
                  },
                  child: Container(
                    height: 51.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.31.r),
                      color: AppColors.blueColor,
                    ),
                    child: Center(
                      child: Text(
                        "Sign Out",
                        style: jost500(16.sp, AppColors.backgroundColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 140.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
