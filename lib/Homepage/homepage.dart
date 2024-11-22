import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:get/get.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/widgets/tabs_appbar.dart';

import '../Drawer/drawer.dart';
import '../calendar_screen/event_card.dart';
import '../const/images.dart';
import '../profile_screen/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileVM = Get.put(ProfileController());
  final Homecontroller homeVM = Get.find<Homecontroller>();


  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    profileVM.getUserData();
    profileVM.getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {}); // Update UI when search text changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabsAppBar(),
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
        },
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 19.h),
          child: Column(
            children: [

              Expanded(
                child: ListView(
                  children: [
                    // Section Title - Attending
                    Text(
                      "Attending",
                      style: jost700(16.37.sp, AppColors.blueColor),
                    ),
                    SizedBox(height: 10,),
                    // ListView.builder for Event Cards
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('events').where("attending", arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                      builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(color: AppColors.blueColor,));
                        } else if (snapshot.hasError){
                          debugPrint("Error in events stream home page: ${snapshot.error}");
                          return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
                        } else if(snapshot.data!.docs.length == 0 && snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("You are attending no events.", style: jost500(16.sp, AppColors.blueColor),));
                        } else if(snapshot.connectionState == ConnectionState.none){
                          return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
                        } else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){

                          var events = snapshot.data!.docs;

                          return Container(
                            height: 120.h,// Adjusted width for better match
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                return _buildEventCard(events[index]);
                              },
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                        
                        

                      }
                    ),
                    // Section Title - Events
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(UserProfilePage());
                        },
                        child: Text(
                          "Events",
                          style: TextStyle(
                            fontSize: 16.37.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Single Event Card (Detailed)
                    StreamBuilder(
                      stream: homeVM.eventStream(),
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

                          var events = snapshot.data!.docs;

                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
                            shrinkWrap: true,
                            itemCount: events.length, // Number of events you want to display
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.0), // Adjust the space between items
                                child: EventCard(
                                  event: events[index],
                                  imageAsset: events[index]['event_image'], // Use imageAsset instead of imageUrl
                                  title: events[index]['event_name'],
                                  date: events[index]['event_date'],
                                  location: events[index]['event_location'],
                                  credits: '10 CE Credits',
                                  priceRange: "\$" + events[index]['event_price'].toString() + "/seat",
                                ),
                              );
                            },
                          );
                        } else {
                          return SizedBox();
                        }

                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build a horizontal event card
  Widget _buildEventCard(QueryDocumentSnapshot<Object?>? event) {
    return
      // Main Card Content (Background with Title and Event Info)
      Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Container(
          width: 223.w,
          height: 119.h,
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(

            children: [
              // Row for Image + Title
              Padding(
                padding: EdgeInsets.only(left: 12.w,top: 6.01.h,right: 12.w),
                child: Row(

                  children: [
                    // Event Image (Placeholder)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        event!['event_image'],
                        width: 42.39.w,
                        height: 41.27.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    // Event Title
                    Expanded(
                      child: Text(
                        event!["event_name"]!,
                        style: jost700(10.54.sp, AppColors.backgroundColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Row for Labels (Date/Time, Location, Credits)
              Padding(
                padding: EdgeInsets.only(left: 12.w,top: 6.01.h,right: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date/Time',
                      style: jost700(10.54.sp, AppColors.backgroundColor),
                    ),
                    Text(
                      'Location',
                      style: jost700(10.54.sp, AppColors.backgroundColor),
                    ),
                    Text(
                      'Credits',
                      style: jost700(10.54.sp, AppColors.backgroundColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.68.h), // Spacing between label and values

              // Row for Values (Date, Location, Credits)
              Padding(
                padding: EdgeInsets.only(left: 8.w,right: 11.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event["event_date"]!,
                      style: jost500(8.78.sp, AppColors.backgroundColor),
                    ),
                    Text(
                      event["event_location"]!,
                      style: jost500(8.78.sp, AppColors.backgroundColor),
                    ),
                    Text(
                      "10c",
                      style: jost500(8.78.sp, AppColors.backgroundColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.2.h),
              // Price Tag aligned at the bottom-center inside the Stack with reduced width
              Align(alignment: Alignment.center,
                child: Container(
                  width: 120.w,  // Reduced width
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.free,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r), // Top-left corner radius
                      topRight: Radius.circular(12.r), // Top-right corner radius
                    ),
                  ),
                  child: Text(
                    event["event_price"]!.toString(),
                    style: jost600(10.sp, AppColors.blueColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),


            ],
          ),
        ),
      );


  }

  // Widget _buildDetailedEventCard(Map<String, String> event) {
  //   return Card(
  //     elevation: 5,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Container(
  //       padding: EdgeInsets.all(16),
  //       child: Row(
  //         children: [
  //           // Event Image Placeholder
  //           Container(
  //             width: 100.w,
  //             height: 100.h,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12.r),
  //               color: Colors.grey[300],
  //             ),
  //           ),
  //           SizedBox(width: 12.w),
  //           // Event Details
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   event["title"]!,
  //                   style: TextStyle(
  //                     fontSize: 18.sp,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 SizedBox(height: 4.h),
  //                 Text(
  //                   event["location"]!,
  //                   style: TextStyle(fontSize: 14.sp, color: Colors.grey),
  //                 ),
  //                 SizedBox(height: 8.h),
  //                 Text(
  //                   event["date"]!,
  //                   style: TextStyle(fontSize: 14.sp),
  //                 ),
  //                 SizedBox(height: 4.h),
  //                 Text(
  //                   event["credits"]!,
  //                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(height: 4.h),
  //                 Text(
  //                   event["price"]!,
  //                   style: TextStyle(fontSize: 14.sp, color: Colors.blue),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // View Button
  //           ElevatedButton(
  //             onPressed: () {},
  //             style: ElevatedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8.r),
  //               ),
  //             ),
  //             child: Text(
  //               "View",
  //               style: TextStyle(fontSize: 14.sp),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}