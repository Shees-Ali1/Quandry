import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/otherUser/OtherUserProfile.dart';
import 'package:quandry/setting_screen/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../const/images.dart';
import '../const/textstyle.dart';
import '../widgets/appbar_small.dart';

class UserProfilePage extends StatefulWidget {

  final bool navbar;

  UserProfilePage({required this.navbar});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final ProfileController profileVM = Get.put(ProfileController());
  bool isFollowing = false;

  void initState(){
    super.initState();
    // profileVM.getUserData();
  }


  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  Future<void> _refresh () async {
   await profileVM.getUserData();
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: widget.navbar == false ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              children: [
                if(widget.navbar == false)
                Padding(
                  padding: EdgeInsets.only(top: 40.h, left: 16.w),
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
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h,),
                    child: Text(
                      '@${profileVM.name.value}',
                      textAlign: TextAlign.center,
                      style: jost700(19.sp, Colors.white),
                    ),
                  ),
                ),
                if(widget.navbar == false)
                  Padding(
                  padding: EdgeInsets.only(right: 16.0.w),
                  child: SizedBox(width: 36.w,),
                )
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
            : SingleChildScrollView(
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
                            backgroundColor: AppColors.greenbutton,
                            backgroundImage: profileVM.profilePicture.value != "" ? NetworkImage(profileVM.profilePicture.value) : null,
                            child: profileVM.profilePicture.value != "" ? SizedBox() : Icon(Icons.person, size: 25.w, color: AppColors.primaryColor,),
                          ),
                          SizedBox(width: 30.w), // Space between image and text
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
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              profileVM.name.value,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
              //      SizedBox(width: 2.w),
                          Image.asset('assets/images/qwandery-verified-professional.png',height: 16.h,width: 16.w,),
                          Expanded(child: SizedBox()),
                          SizedBox(
                            width: 150.w,
                            child: ElevatedButton(
                              onPressed: (){
                                Get.to(SettingsScreen());
                              },
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(color: AppColors.backgroundColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AppColors.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      profileVM.bio.value != ""
                          ? Align(alignment: Alignment.centerLeft,child: Text(profileVM.bio.value, style: TextStyle(fontSize: 14.sp, color: Colors.black87), textAlign: TextAlign.start,))
                          : Align(alignment: Alignment.centerLeft,child: Text("You don't have a bio.", style: TextStyle(fontSize: 14.sp, color: Colors.black87), textAlign: TextAlign.start,)),
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
                children: profileVM.favourites.map((favourite) => _buildChip(favourite['favourite_name'])).toList(),
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
              SizedBox(height: 80.0.h),


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
                  type,
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


                        return SizedBox(
                          height: 300, // Adjust height for list
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: (){
                                  Get.to(OtherUserProfilePage(uid: users[index]['uid']));
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
