import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/images.dart';
import 'package:get/get.dart';

import 'package:quandry/const/textstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/controllers/event_contorller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/profile_screen/user_profile.dart';
import 'package:quandry/suggestions.dart';

import '../otherUser/OtherUserProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventDetail extends StatefulWidget {

  final QueryDocumentSnapshot<Object?> event;


  EventDetail({super.key, required this.event});


  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {

  final EventController eventVM = Get.put(EventController());

  @override
  void initState (){
    super.initState();
    eventVM.followers.value = widget.event['following'];
    eventVM.planned.value = widget.event['attending'];
    eventVM.favourite.value = widget.event['favourited'];
    eventVM.attended.value = widget.event['attended'];
    eventVM.reviews.value = widget.event['reviews'];

    if(eventVM.reviews.any((review)=> review["user_id"] == FirebaseAuth.instance.currentUser!.uid)){
      eventVM.has_given_review.value = true;
    } else {
      eventVM.has_given_review.value = false;
    }

    print(eventVM.has_given_review.value);


    print(eventVM.reviews);
  }

  @override
  void dispose(){
    super.dispose();
    eventVM.has_given_review.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                widget.event['event_image'],
                width: double.infinity,
              ),
              Positioned(
                  top: 50,
                  left: 25,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: Image.asset(
                        'assets/images/event_back.png',
                        height: 36.h,
                      ))),
              Positioned(
                  bottom: 35.h,
                  left: 18.w,
                  child: Text(
                      widget.event['event_name'],
                    style: jost700(26.sp, Color.fromRGBO(255, 255, 255, 1)),
                    maxLines: 2,
                  )),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.w,top: 16.h),
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(216, 229, 236, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          topLeft: Radius.circular(12.r)),),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Icon(FontAwesomeIcons.calendarDay, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text( widget.event['event_date'],
                              style: montserrat600(14.sp, AppColors.blueColor),
                            ),
                            SizedBox(width: 105.w,),
                            Image.asset('assets/images/singlestar.png',height: 18.h,width: 18.w,),
                            Text(' ${widget.event["average_rating"]}',style: jost600(14.sp, AppColors.blueColor),),
                            Text(' (${widget.event["reviews"].length})',style: jost400(14.sp, AppColors.blueColor),)


                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Expanded(child: Text(widget.event['event_location'], style: jost600(14.sp, AppColors.blueColor),)),
                            SizedBox(),
                            FaIcon(
                              FontAwesomeIcons.bookOpen, // Use the Font Awesome book icon
                              size: 14.sp,
                              color: AppColors.blueColor,
                            ),
                            SizedBox(width: 5.w),
                            Text(widget.event['event_credits'] + " Cred.   ", style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.tag, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text("\$" + widget.event['event_price'].toString() + "/seat", style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.ticket, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text(widget.event['event_building'], style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 37.h,
                    decoration: BoxDecoration(color: AppColors.blueColor,borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r)),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/person_check.png',height: 16.h,width: 14.w,),
                        SizedBox(width: 7.w,),
                        Text(widget.event['event_organizer'] ,style: montserrat600(10.sp, AppColors.whiteColor),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(22.w, 0.h, 31.w, 0.w),
                    //  padding: EdgeInsets.all(22),
                    height: 101.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _showUserDialog(context, "followers");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 22.0.h),
                            child: Column(
                              children: [
                                Text(
                                  "Following",
                                  style:
                                  jost600(14.sp, AppColors.backgroundColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Obx(
                                    ()=> Text(
                                    eventVM.followers.length.toString(),
                                    style:
                                    jost700(24.sp, AppColors.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 101.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(10, 42, 58, 1.0), // Top color
                                Color.fromRGBO(
                                    216, 229, 236, 1.0), // Middle color
                                Color.fromRGBO(10, 42, 58, 1.0), // Bottom color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.505, 1.0],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _showUserDialog(context, "planned");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 22.0.h),
                            child: Column(
                              children: [
                                Text(
                                  "Planned",
                                  style:
                                  jost600(14.sp, AppColors.backgroundColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Obx(
                                    ()=> Text(
                                    eventVM.planned.length.toString(),
                                    style:
                                    jost700(24.sp, AppColors.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 101.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(10, 42, 58, 1.0), // Top color
                                Color.fromRGBO(
                                    216, 229, 236, 1.0), // Middle color
                                Color.fromRGBO(10, 42, 58, 1.0), // Bottom color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.505, 1.0],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _showUserDialog(context, "favourite");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 22.0.h),
                            child: Column(
                              children: [
                                Text(
                                  "Favourited",
                                  style:
                                  jost600(14.sp, AppColors.backgroundColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Obx(
                                    ()=> Text(
                                    eventVM.favourite.length.toString(),
                                    style:
                                    jost700(24.sp, AppColors.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Description',
                        style: jost700(16.sp, AppColors.blueColor),
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    widget.event["event_description"],
                    style: jost400(14.sp, Color.fromRGBO(52, 51, 51, 1)),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),

                  GestureDetector(
                    onTap: (){
                      Get.to(SuggestEventForm());
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 40.h,
                        width: 150.w,
                        decoration: BoxDecoration(color: AppColors.blueColor,borderRadius: BorderRadius.circular(10.r)),
                        child: Center(child: Text('Suggest Edits',style: montserrat600(12.sp, AppColors.whiteColor),)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Estimated CE Credits:',
                        style: jost700(16.sp, AppColors.blueColor),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 76.h,
                        width: 161.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 13.w, ),
                              height: 37.h,
                              width: 161.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    topLeft: Radius.circular(12.r)),
                              ),
                              child: Row(

                                children: [
                                  Text('Substance Abuse',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10.sp,color: Colors.white),),
                                  SizedBox(width: 28.w,),
                                  Text('8',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30.sp,color: Colors.white,),),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.w, ),
                              decoration: BoxDecoration(
                                color: AppColors.appbar_text,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                              ),
                              height: 37.h,
                              child: Row(
                                children: [Image.asset('assets/images/check.png',height: 11.h,width: 11.w,),
                                  SizedBox(width: 5.w,),
                                  Text('American Physchology\nAssociation (APA)',style: montserrat600(8.sp, AppColors.blueColor),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 76.h,
                        width: 161.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 13.w, ),
                              height: 37.h,
                              width: 161.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    topLeft: Radius.circular(12.r)),
                              ),
                              child: Row(

                                children: [
                                  Text('Addiction Treatment',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10.sp,color: Colors.white),),
                                  SizedBox(width: 10.w,),
                                  Text('4',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30.sp,color: Colors.white,),),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.w, ),
                              decoration: BoxDecoration(
                                color: AppColors.appbar_text,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                              ),
                              height: 37.h,
                              child: Row(
                                children: [Image.asset('assets/images/check.png',height: 11.h,width: 11.w,),
                                  SizedBox(width: 5.w,),
                                  Text('American Physchology\nAssociation (APA)',style: montserrat600(8.sp, AppColors.blueColor),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 46.h,
                        width: 168.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Row(
                            children: [
                              Obx(
                              ()=> InkWell(
                                autofocus: false,
                                onTap: (){
                                  eventVM.favouriteToggle(widget.event['event_id'], widget.event["event_name"]);
                                },
                                child: Image.asset(
                                   eventVM.favourite.contains(FirebaseAuth.instance.currentUser!.uid) ? 'assets/images/heart.png' : 'assets/images/heart_white.png',
                                    height: 21.h,
                                    width: 25.w,
                                  ),
                              ),
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              Text(
                                'Favorite',
                                style: jost700(16.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 46.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Row(
                            children: [
                              Obx(
                              ()=> InkWell(
                                autofocus: false,
                                onTap: (){
                                  eventVM.followToggle(widget.event['event_id']);
                                },
                                child: Image.asset(
                                    eventVM.followers.contains(FirebaseAuth.instance.currentUser!.uid) ? 'assets/images/eye.png' : 'assets/images/eye_white.png',
                                    height: 32.h,
                                    width: 32.w,
                                  ),
                              ),
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              Text(
                                'Follow',
                                style: jost700(16.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46.h,
                        width: 168.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(22.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 9.w),
                          child: Row(
                            children: [
                              Obx(
                                  ()=> InkWell(
                                  autofocus: false,
                                  onTap: (){
                                    eventVM.goingToggle(widget.event["event_id"], widget.event["event_name"], widget.event["event_date"],);
                                  },
                                  child: Container(height: 30.h,width: 30.w,decoration: BoxDecoration(
                                      color: eventVM.planned.contains(FirebaseAuth.instance.currentUser!.uid) ? AppColors.blueColor : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 3.w,color: Colors.white)
                                  ),
                                    child: eventVM.planned.contains(FirebaseAuth.instance.currentUser!.uid) ? Icon(Icons.check,color: Colors.white,size: 15.sp,) : SizedBox(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Text(
                                "I'm going",
                                style: jost700(14.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 46.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(22.r)),
                        child:     Padding(
                          padding:  EdgeInsets.only(left: 9.w),
                          child: Row(
                            children: [
                              Obx(
                              ()=> InkWell(
                                autofocus: false,
                                onTap: (){
                                  eventVM.iWent(widget.event["event_id"]);
                                },
                                child: Container(height: 30.h,width: 30.w,decoration: BoxDecoration(
                                    color: eventVM.attended.contains(FirebaseAuth.instance.currentUser!.uid) ? AppColors.blueColor : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 3.w,color: Colors.white)
                                  ),
                                    child: eventVM.attended.contains(FirebaseAuth.instance.currentUser!.uid) ? Icon(Icons.check,color: Colors.white,size: 15.sp,) : SizedBox(),
                                  ),
                              ),
                              ),
                              SizedBox(width: 14.w,),
                              Text("I went to this",style:jost700(14.sp, Colors.white) ,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if(eventVM.attended.contains(FirebaseAuth.instance.currentUser!.uid) && (eventVM.has_given_review.value == false)){
                      return Column(
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            //  height: 140.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 229, 236, 1),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Column(
                              children: [
                                SizedBox(height: 9.h),
                                Text(
                                  'Attended this Event Previously?',
                                  style: montserrat600(12.sp, AppColors.blueColor),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.only(left: 17.w),
                                  height: 55.h,
                                  width: 229.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.blueColor,
                                    borderRadius: BorderRadius.circular(22.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: List.generate(5, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                                eventVM.selectedStars.value = index + 1; // Update the stars count
                                            },
                                            child: Image.asset(
                                              index < eventVM.selectedStars.value
                                                  ? 'assets/images/star.png' // Filled star
                                                  : 'assets/images/star_white.png', // Unfilled star
                                              height: 26.h,
                                              width: 26.w,
                                            ),
                                          );
                                        }),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        '${eventVM.selectedStars} out of 5',
                                        style: jost500(10.sp, Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InkWell(
                                  onTap: () {
                                    eventVM.giveReview(widget.event['event_id'], eventVM.selectedStars.value.toString()); // Pass the rating to the parent
                                  },
                                  child: Container(
                                    height: 34.h,
                                    width: 105.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.blueColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Rate',
                                        style: montserrat600(12.sp, AppColors.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 11.h),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (eventVM.attended.contains(FirebaseAuth.instance.currentUser!.uid) && (eventVM.has_given_review.value == true)) {
                      return Padding(
                        padding:  EdgeInsets.only(top: 8.0.h),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(216, 229, 236, 1),
                              borderRadius: BorderRadius.circular(14.r)),
                          padding: EdgeInsets.all(10.w),
                          alignment: Alignment.center,
                          child: Text(
                            'Thank You for your Review.',
                            style: montserrat600(14.sp, AppColors.blueColor),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showUserDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor:       Color.fromRGBO(216, 229, 236, 1),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Following",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  color: AppColors.blueColor,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").snapshots(),
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(color: AppColors.blueColor,));
                    } else if (snapshot.hasError){
                      debugPrint("Error in events stream home page: ${snapshot.error}");
                      return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
                    } else if(snapshot.data!.docs.length == 0 && snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("There are no events at the moment", style: jost500(16.sp, AppColors.blueColor),));
                    } else if(snapshot.connectionState == ConnectionState.none){
                      return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
                    } else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){

                      var users = snapshot.data!.docs;

                      if(type == "followers"){
                        users.retainWhere((user) => eventVM.followers.contains(user['uid']));
                      } else if(type == "planned"){
                        users.retainWhere((user) => eventVM.planned.contains(user['uid']));
                      } else if (type == "favourite"){
                        users.retainWhere((user) => eventVM.favourite.contains(user['uid']));
                      }


                      return SizedBox(
                        height: 300, // Adjust height for list
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: (){
                                if(users[index]["uid"] != FirebaseAuth.instance.currentUser!.uid){
                                  Get.to(OtherUserProfilePage(uid: users[index]['uid']));
                                } else {
                                  Get.to(UserProfilePage(navbar: false,));
                                }
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(users[index]['profile_pic']),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            users[index]['name'],
                                            style: TextStyle(color:AppColors.blueColor, fontWeight: FontWeight.bold),
                                          ),
                                          users[index]['is_verified'] == true
                                              ? Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Image.asset(
                                              'assets/images/qwandery-verified-professional.png',
                                              height: 12.h,
                                              width: 12.w
                                              ,
                                            ),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                      Text(
                                        users[index]['name'],
                                        style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return SizedBox();
                    }


                  }
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}