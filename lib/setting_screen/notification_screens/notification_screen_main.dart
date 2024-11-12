import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/setting_screen/notification_screens/notifications_detail.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:flutter_screenutil/flutter_screenutil.dart';



class NotificationScreenMain extends StatelessWidget {
  const NotificationScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppbarSmall(
        title: "Notification",


      ),

      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Get.to(NotificationsDetail());
                },
              child: Container(
                height: 306.71.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                        height:169.21.h,
                        width: 155.92.w,
                        child: Image.asset(AppImages.main_notification)),
                    SizedBox(height: 30.5.h),
                    Text("Two Notifications!", style: jost700(18.sp, AppColors.blueColor),),
                    SizedBox(height: 7.h),
                    Text("Lorem ipsum dolor sit amet, consectetur \n adipiscing elit sed do eiusmod tempor", style: jost400(16.sp, AppColors.calendartext),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
