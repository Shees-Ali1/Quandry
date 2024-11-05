import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:flutter_screenutil/flutter_screenutil.dart';



class NotificationsDetail extends StatelessWidget {
  const NotificationsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppbarSmall(
        title: "Notification", // Set the title for the app bar
        iconImage: AppImages.back_icon, // Set your custom back icon
        onIconTap: () {
          Get.back(); // Use GetX to navigate back
        },
        iconHeight: 15.h, // Custom height
        iconWidth: 20.w,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 53.65.h),
            Text("Today",style: jost700(19.27.sp, AppColors.blueColor),),
            SizedBox(height: 17.11.h),
            /// Notification Card
            Container(
              height: 148.53.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(13.31.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15), // shadow color with opacity
                    spreadRadius: 2, // how much the shadow spreads
                    blurRadius: 10, // how blurry the shadow is
                    offset: Offset(0, 4), // x and y offset for the shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 14.18.w,top:14.35.h),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:56.51.h,
                      width:56.51.w,
                      child: Image.asset(AppImages.notification_card_image,fit: BoxFit.contain,),
                    ),
                    SizedBox(width: 15.18.w),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking Successful",style: jost700(11.21.sp, AppColors.blueColor),),
                        Text("30 March 2024 | 10:00 AM ",style: jost400(11.21.sp, AppColors.calendartext),),
                        SizedBox(height: 7.35.h),
                        Container(
                          height: 86.h,
                          width: 210.w,

                          child: Text("You have successfully booked the dance festival tonight event. The event will be held on Sunday 1 April at Living Venue. Timing is 10:00 PM. Don’t forget to visit.Enjoy the event! ",
                            style: jost500(11.21.sp, AppColors.calendartext),),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
            SizedBox(height: 33.72.h),
            Text("Yesterday",style: jost700(19.27.sp, AppColors.blueColor),),
            SizedBox(height: 17.11.h),
            /// Notification Card
            Container(
              height: 148.53.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(13.31.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15), // shadow color with opacity
                    spreadRadius: 2, // how much the shadow spreads
                    blurRadius: 10, // how blurry the shadow is
                    offset: Offset(0, 4), // x and y offset for the shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 14.18.w,top:14.35.h),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:56.51.h,
                      width:56.51.w,
                      child: Image.asset(AppImages.notification_card_image,fit: BoxFit.contain,),
                    ),
                    SizedBox(width: 15.18.w),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking Successful",style: jost700(11.21.sp, AppColors.blueColor),),
                        Text("30 March 2024 | 10:00 AM ",style: jost400(11.21.sp, AppColors.calendartext),),
                        SizedBox(height: 7.35.h),
                        Container(
                          height: 86.h,
                          width: 210.w,

                          child: Text("You have successfully booked the dance festival tonight event. The event will be held on Sunday 1 April at Living Venue. Timing is 10:00 PM. Don’t forget to visit.Enjoy the event! ",
                            style: jost500(11.21.sp, AppColors.calendartext),),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ]
        ),
            ),

    );
  }
}
