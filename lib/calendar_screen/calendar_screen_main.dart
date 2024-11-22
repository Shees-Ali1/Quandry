import 'package:flutter/material.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/calendar_screen/event_card.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/setting_screen/notification_screens/notification_screen_main.dart';
import 'package:quandry/widgets/appbar.dart';
import 'package:quandry/widgets/custom_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/widgets/tabs_appbar.dart'; // Ensure GetX is imported
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CalendarScreenMain extends StatefulWidget {
  const CalendarScreenMain({super.key});

  @override
  State<CalendarScreenMain> createState() => _CalendarScreenMainState();
}

class _CalendarScreenMainState extends State<CalendarScreenMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Homecontroller homeVM = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        // Assign the scaffold key

        appBar:TabsAppBar(),
        backgroundColor: AppColors.backgroundColor,
     //   drawer: MyDrawer(), // Your custom drawer widget
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 14.h),
                /// Calendar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 280.h, // Set a specific height for the calendar
                    child: CustomCalendar(),
                  ),
                ),
                // SizedBox(height: 18.63.h),
                Text(
                  " Events Scheduled for Attendance",
                  style: jost700(16.37.sp, AppColors.blueColor),
                ),
                SizedBox(height: 12.h),

                /// List of EventCards
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("events").where("attending", arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
        ),
      ),
    );
  }
}
