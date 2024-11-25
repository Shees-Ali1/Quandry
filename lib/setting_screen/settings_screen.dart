import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/Drawer/online_Support/online_support.dart';
import 'package:quandry/Drawer/privacy_policy_screen/privacy_policy.dart';
import 'package:quandry/Drawer/terms_and_condition/terms_and_condition.dart';
import 'package:quandry/auth/login.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/profile_screen/profile_screen_main.dart';
import 'package:quandry/profile_screen/user_profile.dart';
import 'package:quandry/setting_screen/change_language_screen/select_language_screen.dart';
import 'package:quandry/setting_screen/change_password/change_password.dart';
import 'package:quandry/setting_screen/notification_screens/notification_screen_main.dart';
import 'package:quandry/setting_screen/notification_setting/notification_setting.dart';
import 'package:quandry/subscription_screen.dart';
import 'package:quandry/widgets/appbar_small.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ProfileController profileVM = Get.put(ProfileController());


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(
          ()=> Scaffold(
          appBar: AppbarSmall(title: 'Profile Settings'),
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
                          radius: 50,
                          backgroundColor: AppColors.greenbutton,
                          backgroundImage: profileVM.profilePicture.value != "" ? NetworkImage(profileVM.profilePicture.value) : null,
                          child: profileVM.profilePicture.value != "" ? SizedBox() : Icon(Icons.person, size: 25.w, color: AppColors.primaryColor,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Profile Name
                  Text(profileVM.name.value, style: jost700(16.sp, AppColors.blueColor)),
                  SizedBox(height: 1.h),
                  Text(profileVM.email.value, style: jost400(16.sp, AppColors.blueColor)),
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
                  Container(
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
                            'Profile: ${profileVM.profileType.value}',
                            style: jost600(16.sp, AppColors.blueColor),
                          ),
                          Switch(
                            value: profileVM.profileType.value == "Public" ? false : true,
                            activeColor: AppColors.blueColor,
                            onChanged: (value) async{
                             if(value == true) {
                               profileVM.profileType.value = "Private";
                               await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                 "profile_type": "Private",
                               });
                             } else {
                               profileVM.profileType.value = "Public";
                               await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                 "profile_type": "Public",
                               });
                             }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              color: AppColors.blueColor,
                              size: 16.sp,
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
                              color: AppColors.blueColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Online Support
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
                              color: AppColors.blueColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Privacy Settings
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
                              color: AppColors.blueColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Privacy Policy
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
                              color: AppColors.blueColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Subscription Screen
                  GestureDetector(
                    onTap: () {
                      Get.to(SubscriptionScreen());
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
                              "Subscription",
                              style: jost600(16.sp, AppColors.blueColor),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.blueColor,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  /// Sign Out Button
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(LoginView());
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
                              "Sign Out",
                              style: jost600(16.sp, AppColors.blueColor),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.blueColor,
                              size: 16.sp,
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
      ),
    );
  }
}
