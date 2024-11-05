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


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(

        appBar: AppbarSmall(
          title: "Settings", // Set the title for the app bar
          iconImage: AppImages.notification_icon_small, // Set your custom back icon
          onIconTap: () {
            Get.to(NotificationScreenMain());// Open drawer on icon tap
          },
          iconHeight: 25.h, // Custom height
          iconWidth: 30.w, // Custom width
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
                SizedBox(height: 30.h),
                /// Online Support
                GestureDetector(
                  onTap: (){

                    Get.to(TechnicalSupportChatScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(AppImages.online_support_icon,height: 21.h,width: 15.w,color: AppColors.blueColor,),
                      SizedBox(width: 7.2.w),
                      Text(
                        "Online Support",
                        style: jost600(16.sp, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                /// Terms and conditions
                GestureDetector(
                  onTap: (){

                    Get.to(TermsAndConditions());
                  },
                  child: Row(
                    children: [
                      Image.asset(AppImages.term_condition_icon,height: 21.h,width: 15.w,color: AppColors.blueColor,),
                      SizedBox(width: 7.2.w),
                      Text(
                        "Terms and conditions",
                        style: jost600(16.sp, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                /// Privacy Policy
                GestureDetector(
                  onTap: (){
                    Get.to(PrivacyPolicy());
                  },
                  child: Row(
                    children: [
                      Image.asset(AppImages.privacy_policy_icon,height: 18.h,width: 15.w,color: AppColors.blueColor,),
                      SizedBox(width: 7.2.w),
                      Text(
                        "Privacy Policy",
                        style: jost600(16.sp, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
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
