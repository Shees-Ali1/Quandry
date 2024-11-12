import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/setting_screen/settings_screen.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:quandry/widgets/custom_switch.dart';



class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppbarSmall(
        title: "Notifications", // Set the title for the app bar

      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 33.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 9.h),
            /// Notification Switch
            Container(
                height:61.h,
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
                        "Allow all notifications ",
                        style: jost600(11.41.sp, AppColors.blueColor),
                      ),
                      CustomSwitch(),
                    ],
                  ),
                )
            ),
            SizedBox(height: 20.h),
            Text("All notifications", style: jost700(13.sp, AppColors.blueColor),),
            SizedBox(height: 10.h),
            /// Email Switch
            Container(
                height:61.h,
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
                        "Allow all notifications ",
                        style: jost600(11.41.sp, AppColors.blueColor),
                      ),
                      CustomSwitch(),
                    ],
                  ),
                )
            ),
            SizedBox(height: 5.71.h),
            /// Push Switch
            Container(
                height:61.h,
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
                        "Allow all notifications ",
                        style: jost600(11.41.sp, AppColors.blueColor),
                      ),
                      CustomSwitch(),
                    ],
                  ),
                )
            ),
            Spacer(),
            /// Save Button
            CustomButton(text: "Save", color: AppColors.blueColor, onPressed: (){

            }),
          ],
        ),
      ),
    );
  }
}
