import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/controllers/other_user_profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/setting_screen/settings_screen.dart';

import '../const/images.dart';
import '../const/textstyle.dart';
import '../widgets/appbar_small.dart';

class OtherUserProfilePage extends StatefulWidget {
  final String uid;

  OtherUserProfilePage({required this.uid});

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {

  final OtherUserProfileController profileVM = Get.put(OtherUserProfileController());

  void initState(){
    super.initState();
    profileVM.getUserData(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            child: Stack(
              alignment: Alignment.center, // Centers the title
              children: [
                // Back arrow button on the left
                Positioned(
                  left: 16.w,
                  top: 45.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/event_back.png',
                      height: 36.h,
                    ),
                  ),
                ),

                // Title in the center
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Text(
                      "@" + profileVM.name.value,
                      textAlign: TextAlign.center,
                      style: jost700(19.sp, Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        body: profileVM.loading.value == true
            ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
            : profileVM.errorOccurred.value != ""
            ? Center(
          child: Text(
            profileVM.errorOccurred.value,
            style: jost500(18.sp, AppColors.primaryColor),
          ),)
            :SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                elevation: 4,
                color: Color.fromRGBO(216, 229, 236, 1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Profile image
                          CircleAvatar(
                            radius: 45.r,
                            backgroundImage: NetworkImage(
                                profileVM.profilePicture.value
                            ),
                          ),
                          SizedBox(width: 20.w), // Space between image and text
                          // Column for Followers and Following
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Followers and Following Section
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        profileVM.followers.length.toString(), // Replace with dynamic follower count
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: AppColors.blueColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.w), // Space between image and text
                                  Column(
                                    children: [
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        profileVM.following.length.toString(), // Replace with dynamic following count
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: AppColors.blueColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      profileVM.name.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueColor,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(width: 2,),
                                    profileVM.verified.value == true
                                        ? Padding(
                                      padding: EdgeInsets.only(top: 2.0, left: 2.0),
                                      child: Image.asset(
                                        'assets/images/qwandery-verified-professional.png',
                                        height: 14,
                                        width: 14,
                                      ),
                                    )
                                        : SizedBox(),
                                  ],
                                ),
                                Text(
                                  '${profileVM.name.value}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade700
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          //      SizedBox(width: 2.w),
                                            SizedBox(width: 5.w),
                          // SizedBox(
                          //   width: 170.w,
                          //   child: ElevatedButton(
                          //     onPressed: (){
                          //       Get.to(SettingsScreen());
                          //     },
                          //     child: Text(
                          //       'Edit Profile',
                          //       style: TextStyle(color: AppColors.backgroundColor),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor:
                          //       AppColors.blueColor,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 170.w,
                            child: ElevatedButton(
                              onPressed: (){
                                if(profileVM.profileType.value == "Public"){
                                  profileVM.followToggle(widget.uid);
                                } else {
                                  profileVM.followRequestToggle(widget.uid);
                                }
                              },
                              child: Text(
                                profileVM.profileType.value == "Public" ?
                                profileVM.followers.contains(FirebaseAuth.instance.currentUser!.uid)
                                    ? "Unfollow"
                                    : "Follow"
                                    : profileVM.incoming_requests.contains(FirebaseAuth.instance.currentUser!.uid)
                                    ? "Requested"
                                    : profileVM.followers.contains(FirebaseAuth.instance.currentUser!.uid)
                                    ? "Unfollow"
                                    : "Follow",
                                style: TextStyle(color: AppColors.backgroundColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: profileVM.followers.contains(FirebaseAuth.instance.currentUser!.uid)
                                    ? AppColors.greenbutton
                                    : AppColors.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      profileVM.bio.value != ""
                          ? Align(alignment: Alignment.centerLeft,child: Text(profileVM.bio.value, style: TextStyle(fontSize: 14.sp, color: Colors.black87), textAlign: TextAlign.start,))
                          : Align(alignment: Alignment.centerLeft,child: Text("You don't have a bio.", style: TextStyle(fontSize: 14.sp, color: Colors.black87), textAlign: TextAlign.start,)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              // Additional Information Section
              if(profileVM.profileType.value == "Public")
                Column(
                  children: [
                    Text(
                      "  Additional Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: AppColors.blueColor,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Location:", profileVM.location.value),
                            _buildInfoRow("Joined:", profileVM.joined.value),
                            _buildInfoRow("Profile:", profileVM.profileType.value),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "  Favorites",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    profileVM.favourites.length != 0
                        ? Wrap(
                      spacing: 8.0, // Space between chips horizontally
                      runSpacing: 4.0, // Space between chips vertically
                      children: profileVM.favourites.map((favourite) => _buildChip(favourite["favourite_name"])).toList(),
                    )
                        : Align(alignment: Alignment.center,child: Text("  No favourite topics yet.", style: jost500(15.sp, AppColors.greenbutton),)),
                    SizedBox(height: 20.0),

                    // Events Attending Section
                    Text(
                      "Events Attending",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    profileVM.events.length != 0
                        ? ListView.builder(
                        itemCount: profileVM.events.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return _buildEventCard(profileVM.events[index]['event_name'], profileVM.events[index]['event_date']);
                        })
                        : Align(alignment: Alignment.center,child: Text("No events attending yet.", style: jost500(15.sp, AppColors.greenbutton),)),
                  ],
                ),
              if(profileVM.profileType.value == "Private" && profileVM.followers.contains(FirebaseAuth.instance.currentUser!.uid))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  Additional Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: AppColors.blueColor,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Location:", profileVM.location.value),
                            _buildInfoRow("Joined:", profileVM.joined.value),
                            _buildInfoRow("Profile:", profileVM.profileType.value),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "  Favorites",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    profileVM.favourites.length != 0
                        ? Wrap(
                      spacing: 8.0, // Space between chips horizontally
                      runSpacing: 4.0, // Space between chips vertically
                      children: profileVM.favourites.map((favourite) => _buildChip(favourite["favourite_name"])).toList(),
                    )
                        : Align(alignment: Alignment.center,child: Text("  No favourite topics yet.", style: jost500(15.sp, AppColors.greenbutton),)),
                    SizedBox(height: 20.0),

                    // Events Attending Section
                    Text(
                      "Events Attending",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    profileVM.events.length != 0
                        ? ListView.builder(
                        itemCount: profileVM.events.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return _buildEventCard(profileVM.events[index]['event_name'], profileVM.events[index]['event_date']);
                        })
                        : Align(alignment: Alignment.center,child: Text("No events attending yet.", style: jost500(15.sp, AppColors.greenbutton),)),
                  ],
                ),
              if(profileVM.profileType.value == "Private" && !profileVM.followers.contains(FirebaseAuth.instance.currentUser!.uid))
                Center(child:Text("This account is Private.", style: TextStyle(fontSize: 16.sp, color: AppColors.blueColor), textAlign: TextAlign.center,),),

              SizedBox(height: 20.0),

            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build Chips
  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.blueColor,
    );
  }

  // Helper function to build Event Cards
  Widget _buildEventCard(String title, String date) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: AppColors.blueColor,
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(Icons.event, color: AppColors.backgroundColor),
        title: Text(title, style: TextStyle(color: AppColors.backgroundColor)),
        subtitle:
        Text(date, style: TextStyle(color: AppColors.backgroundColor)),
      ),
    );
  }

  // Helper function to build info rows
  Widget _buildInfoRow(String label, String value) {
    return Container(
      color: AppColors.blueColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.greenbutton,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              value,
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
