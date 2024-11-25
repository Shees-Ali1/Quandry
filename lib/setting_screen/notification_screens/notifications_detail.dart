import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/notification_controller.dart';
import 'package:quandry/setting_screen/notification_screens/components/notification_container.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NotificationsDetail extends StatefulWidget {
  const NotificationsDetail({super.key});

  @override
  State<NotificationsDetail> createState() => _NotificationsDetailState();
}

class _NotificationsDetailState extends State<NotificationsDetail> {
  final NotificationController controller = Get.put(NotificationController());


  @override
  void initState(){
    super.initState();
    controller.seenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppbarSmall(
        title: "Notification", // Set the title for the app bar

      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("notifications").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").snapshots(),
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: AppColors.blueColor,));
                  } else if (snapshot.hasError){
                    debugPrint("Error in events stream home page: ${snapshot.error}");
                    return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
                  } else if(snapshot.data!.docs.length == 0 && snapshot.data!.docs.isEmpty) {
                    return Padding(
                      padding:  EdgeInsets.only(top: Get.height * .40),
                      child: Center(child: Text("No notifications yet.", style: jost500(16.sp, AppColors.blueColor),)),
                    );
                  } else if(snapshot.connectionState == ConnectionState.none){
                    return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
                  } else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){

                    var notification = snapshot.data!.docs;

                    return ListView.builder(
                        itemCount: notification.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.only(top: index != 0 ? 10.h : 0),
                            child: NotificationContainer(
                              notification_id: notification[index]["notification_id"],
                                requester_id: notification[index]["requester_id"],
                                sent_at: notification[index]["sent_at"],
                                action_taken: notification[index]["action_taken"],
                                notification_type: notification[index]["notification_type"]
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }



            })

            // SizedBox(height: 53.65.h),
            // Text("Today",style: jost700(19.27.sp, AppColors.blueColor),),
            // SizedBox(height: 17.11.h),
            // /// Notification Card
            // Container(
            //   height: 148.53.h,
            //   decoration: BoxDecoration(
            //     color: AppColors.backgroundColor,
            //     borderRadius: BorderRadius.circular(13.31.r),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.15), // shadow color with opacity
            //         spreadRadius: 2, // how much the shadow spreads
            //         blurRadius: 10, // how blurry the shadow is
            //         offset: Offset(0, 4), // x and y offset for the shadow
            //       ),
            //     ],
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 14.18.w,top:14.35.h),
            //     child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           height:56.51.h,
            //           width:56.51.w,
            //           child: Image.asset(AppImages.notification_card_image,fit: BoxFit.contain,),
            //         ),
            //         SizedBox(width: 15.18.w),
            //         Column(crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Booking Successful",style: jost700(11.21.sp, AppColors.blueColor),),
            //             Text("30 March 2024 | 10:00 AM ",style: jost400(11.21.sp, AppColors.calendartext),),
            //             SizedBox(height: 7.35.h),
            //             Container(
            //               height: 86.h,
            //               width: 210.w,
            //
            //               child: Text("You have successfully booked the dance festival tonight event. The event will be held on Sunday 1 April at Living Venue. Timing is 10:00 PM. Don’t forget to visit.Enjoy the event! ",
            //                 style: jost500(11.21.sp, AppColors.calendartext),),
            //             ),
            //           ],
            //         )
            //
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 33.72.h),
            // Text("Yesterday",style: jost700(19.27.sp, AppColors.blueColor),),
            // SizedBox(height: 17.11.h),
            // /// Notification Card
            // Container(
            //   height: 148.53.h,
            //   decoration: BoxDecoration(
            //     color: AppColors.backgroundColor,
            //     borderRadius: BorderRadius.circular(13.31.r),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.15), // shadow color with opacity
            //         spreadRadius: 2, // how much the shadow spreads
            //         blurRadius: 10, // how blurry the shadow is
            //         offset: Offset(0, 4), // x and y offset for the shadow
            //       ),
            //     ],
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 14.18.w,top:14.35.h),
            //     child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           height:56.51.h,
            //           width:56.51.w,
            //           child: Image.asset(AppImages.notification_card_image,fit: BoxFit.contain,),
            //         ),
            //         SizedBox(width: 15.18.w),
            //         Column(crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Booking Successful",style: jost700(11.21.sp, AppColors.blueColor),),
            //             Text("30 March 2024 | 10:00 AM ",style: jost400(11.21.sp, AppColors.calendartext),),
            //             SizedBox(height: 7.35.h),
            //             Container(
            //               height: 86.h,
            //               width: 210.w,
            //
            //               child: Text("You have successfully booked the dance festival tonight event. The event will be held on Sunday 1 April at Living Venue. Timing is 10:00 PM. Don’t forget to visit.Enjoy the event! ",
            //                 style: jost500(11.21.sp, AppColors.calendartext),),
            //             ),
            //           ],
            //         )
            //
            //       ],
            //     ),
            //   ),
            // ),
          ]
        ),
            ),

    );
  }
}
