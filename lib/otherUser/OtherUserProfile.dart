import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/setting_screen/settings_screen.dart';

import '../const/images.dart';
import '../const/textstyle.dart';
import '../widgets/appbar_small.dart';

class OtherUserProfilePage extends StatefulWidget {
  final String profilePic; // URL or asset path for the profile picture
  final String fullName; // URL or asset path for the profile picture
  final String userName;   // User's username
  final String verified;   // User's username

  OtherUserProfilePage({required this.profilePic, required this.userName,required this.verified,required this.fullName});

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: 55.h,
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
                    '${widget.fullName}',
                    textAlign: TextAlign.center,
                    style: jost700(19.sp, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
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
                            '${widget.profilePic}',
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
                                      "120", // Replace with dynamic follower count
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
                                      "80", // Replace with dynamic following count
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
                                    '${widget.fullName}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blueColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(width: 2,),
                                  widget.verified == 'true'
                                      ? Padding(
                                    padding: const EdgeInsets.only(top: 2.0, left: 2.0),
                                    child: Image.asset(
                                      'assets/images/qwandery-verified-professional.png',
                                      height: 14,
                                      width: 14,
                                    ),
                                  )
                                      : SizedBox(),
                                ],
                              ),Text(
                                '${widget.userName}',
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

                            onPressed: toggleFollow,
                            child: Text(
                              isFollowing ? "Unfollow" : "Follow",
                              style: TextStyle(color: AppColors.backgroundColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFollowing
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
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod ",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.h),
            // Additional Information Section
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
                    _buildInfoRow("Location:", "San Francisco, CA"),
                    _buildInfoRow("Joined:", "January 2022"),
                    _buildInfoRow("Profile:", "Private"),
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
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildChip("Photography"),
                _buildChip("Music"),
                _buildChip("Travel"),
                _buildChip("Cooking"),
                _buildChip("Reading"),
              ],
            ),
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
            _buildEventCard("Flutter Conference 2024", "March 15, 2024"),
            _buildEventCard("Tech Meetup", "April 20, 2024"),
            _buildEventCard("Photography Workshop", "May 10, 2024"),
            SizedBox(height: 20.0),


          ],
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
