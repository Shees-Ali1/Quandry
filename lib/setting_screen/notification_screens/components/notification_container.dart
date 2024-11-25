import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/notification_controller.dart';
import 'package:quandry/otherUser/OtherUserProfile.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:get/get.dart';


class NotificationContainer extends StatefulWidget {
  const NotificationContainer({super.key, required this.requester_id, required this.sent_at, required this.action_taken, required this.notification_type, required this.notification_id});

  final String notification_type;
  final Timestamp sent_at;
  final String action_taken;
  final String requester_id;
  final String notification_id;

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {

  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState(){
    super.initState();
    controller.actionTaken.value = widget.action_taken;
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.notification_type == "Follow request" ? StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(widget.requester_id).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
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
            child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,),),
          );
        } else if (snapshot.hasError){
          debugPrint("Error in notifications page: ${snapshot.error}");
          return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
        } else if(!snapshot.data!.exists) {
          return Center(child: Text("This user does not exists", style: jost500(16.sp, AppColors.blueColor),));
        } else if(snapshot.connectionState == ConnectionState.none){
          return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
        } else if(snapshot.hasData && snapshot.data!.exists){

          var user = snapshot.data!;

          return Container(

            padding: EdgeInsets.only(left: 14.18.w, top:14.35.h, right: 14.18.w ,  bottom:14.35.h,),

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
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(OtherUserProfilePage(uid: widget.requester_id));
                  },
                  child: CircleAvatar(
                    radius: 26.r,
                    backgroundColor: AppColors.blueColor,
                    backgroundImage: NetworkImage(user["profile_pic"]),
                  ),
                ),
                SizedBox(width: 15.18.w),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${user["name"]} has requested to follow you.",style: jost700(11.21.sp, AppColors.blueColor),),
                      Text("${formatTimestamp(widget.sent_at)} ",style: jost400(11.21.sp, AppColors.calendartext),),
                      SizedBox(height: 16.h),
                      Obx(
                        () {
                          if(controller.actionTaken.value == "Accepted"){
                            return Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                  loading: controller.loading.value,
                                  width: 110.w,
                                  fontSize: 14.sp,
                                  textColor: Colors.white,
                                  text: "Accepted",
                                  color: AppColors.blueColor,
                                  onPressed: (){
                                  }
                              ),
                            );
                          } else if(controller.actionTaken.value == "Rejected"){
                            return Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                  loading: controller.loading.value,
                                  width: 110.w,
                                  fontSize: 14.sp,
                                  textColor: Colors.white,
                                  text: "Rejected",
                                  color: AppColors.blueColor,
                                  onPressed: (){
                                  }
                              ),
                            );
                          } else {
                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                    loading: controller.loading.value,
                                    width: 105.w,
                                    fontSize: 14.sp,
                                    textColor: Colors.white,
                                    text: "Accept",
                                    color: AppColors.blueColor,
                                    onPressed: (){
                                      if(controller.loading.value == false){
                                        controller.acceptRequest(widget.requester_id, widget.notification_id);
                                      }
                                    }
                                ),
                                CustomButton(
                                    loading: controller.loading.value,
                                    text: "Reject",
                                    color: AppColors.greenbutton,
                                    width: 105.w,
                                    fontSize: 14.sp,
                                    textColor: Colors.white,
                                    onPressed: (){
                                      if(controller.loading.value == false){
                                        controller.rejectRequest(widget.requester_id, widget.notification_id);
                                      }
                                    }
                                ),
                              ],
                            );
                          }
                        })
                    ],
                  ),
                )

              ],
            ),
          );

        } else {
          return SizedBox();
        }


      }
    ) : followedContainer();
  }

  Widget followedContainer(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.requester_id).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
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
              child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,),),
            );
          } else if (snapshot.hasError){
            debugPrint("Error in notifications page: ${snapshot.error}");
            return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
          } else if(!snapshot.data!.exists) {
            return Center(child: Text("This user does not exists", style: jost500(16.sp, AppColors.blueColor),));
          } else if(snapshot.connectionState == ConnectionState.none){
            return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
          } else if(snapshot.hasData && snapshot.data!.exists){

            var user = snapshot.data!;

            return Container(

              padding: EdgeInsets.only(left: 14.18.w, top:14.35.h, right: 14.18.w ,  bottom:14.35.h,),

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
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(OtherUserProfilePage(uid: widget.requester_id));
                    },
                    child: CircleAvatar(
                      radius: 26.r,
                      backgroundColor: AppColors.blueColor,
                      backgroundImage: NetworkImage(user["profile_pic"]),
                    ),
                  ),
                  SizedBox(width: 15.18.w),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${user["name"]} has followed you.",style: jost700(11.21.sp, AppColors.blueColor),),
                        Text("${formatTimestamp(widget.sent_at)} ",style: jost400(11.21.sp, AppColors.calendartext),),
                      ],
                    ),
                  )

                ],
              ),
            );

          } else {
            return SizedBox();
          }


        }
    );
  }

}
