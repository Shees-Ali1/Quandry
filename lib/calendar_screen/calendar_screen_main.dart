import 'package:flutter/material.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/calendar_screen/event_card.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/setting_screen/notification_screens/notification_screen_main.dart';
import 'package:quandry/widgets/appbar.dart';
import 'package:quandry/widgets/custom_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/widgets/tabs_appbar.dart'; // Ensure GetX is imported
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';



class CalendarScreenMain extends StatefulWidget {
  const CalendarScreenMain({super.key});

  @override
  State<CalendarScreenMain> createState() => _CalendarScreenMainState();
}

class _CalendarScreenMainState extends State<CalendarScreenMain> {
  final ProfileController profileVM = Get.put(ProfileController());

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
                if(profileVM.is_deleted.value == false)
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: Get.height *.35),
                        child: Center(child: CircularProgressIndicator()),
                      ); // or any loading widget
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text("No events available");
                    }

                    int? selectedDate; // Variable to hold the selected date
                    DateTime currentMonth = DateTime.now(); // Keeps track of the displayed month
                    DateTime today = DateTime.now(); // Current date

                    var data = snapshot.data!;

                    var eventDates = data["events"].where((event) {
                      try {
                        final eventDate = DateFormat('yyyy-MM-dd').parse(event["event_date"]!);
                        return eventDate.month == currentMonth.month && eventDate.year == currentMonth.year;
                      } catch (e) {
                        return false; // Skip invalid dates
                      }
                    }).map((event) {
                      final eventDate = DateFormat('yyyy-MM-dd').parse(event["event_date"]!);
                      return eventDate.day;
                    }).toList();

                    print(eventDates);

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 280.h, // Set a specific height for the calendar
                        child: CustomCalendar(eventDates: eventDates,),
                      ),
                    );
                  }
                ),
               SizedBox(height: 18.63.h),
                Text(
                  " Events Scheduled for Attendance",
                  style: jost700(16.37.sp, AppColors.blueColor),
                ),
                SizedBox(height: 12.h),

                /// List of EventCards
                if(profileVM.is_deleted.value == false)
                Obx(() {
                  // Fetch events from Firestore and filter by selectedCalenderDate
                  return profileVM.selectedCalenderDate != [] ?  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("events")
                        .where("attending", arrayContains: FirebaseAuth.instance.currentUser!.uid)
                        .get(),  // Fetch events based on selected date
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.only(top: Get.height *.35),
                          child: Center(child: CircularProgressIndicator(color: AppColors.blueColor)),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor)));
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("There are no events at the moment", style: jost500(16.sp, AppColors.blueColor)));
                      }

                      var events = snapshot.data!.docs;

                      events.retainWhere((event) {
                        // Ensure event["event_date"] is in the same format as profileVM.selectedCalenderDate (e.g., 'yyyy-MM-dd')
                        String eventDate = event["event_date"]; // assuming it's in 'yyyy-MM-dd' format
                        return profileVM.selectedCalenderDate.contains(eventDate);
                      });

                      if (events.isEmpty) {
                        return Center(child: Text("No events on this Date", style: jost500(16.sp, AppColors.blueColor)));
                      }

                      if(homeVM.search_fiter.value != ""){
                        events = events.where((event) {
                          final eventName = event['event_name'].toString().toLowerCase();
                          final eventLocation = event['event_location'].toString().toLowerCase();
                          final eventOrganizer = event['event_organizer'].toString().toLowerCase();
                          final query = homeVM.search_fiter.value.toLowerCase();

                          return eventName.contains(query) ||
                              eventLocation.contains(query) ||
                              eventOrganizer.contains(query);
                        }).toList();

                        if (events.isEmpty) {
                          return Center(
                            child: Text(
                              "No events found for your search",
                              style: jost500(16.sp, AppColors.blueColor),
                            ),
                          );
                        }
                      }

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
                    },
                  ) : FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("events")
                        .where("attending", arrayContains: FirebaseAuth.instance.currentUser!.uid)
                        .get(),  // Fetch events based on selected date
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: AppColors.blueColor));
                      } else if (snapshot.hasError) {
                        return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor)));
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("There are no events at the moment", style: jost500(16.sp, AppColors.blueColor)));
                      }

                      var events = snapshot.data!.docs;

                      events.retainWhere((event) {
                        // Ensure event["event_date"] is in the same format as profileVM.selectedCalenderDate (e.g., 'yyyy-MM-dd')
                        String eventDate = event["event_date"]; // assuming it's in 'yyyy-MM-dd' format
                        return profileVM.selectedCalenderDate.contains(eventDate);
                      });

                      if (events.isEmpty) {
                        return Center(child: Text("No events on this Date", style: jost500(16.sp, AppColors.blueColor)));
                      }

                      if(homeVM.search_fiter.value != ""){
                        events = events.where((event) {
                          final eventName = event['event_name'].toString().toLowerCase();
                          final eventLocation = event['event_location'].toString().toLowerCase();
                          final eventOrganizer = event['event_organizer'].toString().toLowerCase();
                          final query = homeVM.search_fiter.value.toLowerCase();

                          return eventName.contains(query) ||
                              eventLocation.contains(query) ||
                              eventOrganizer.contains(query);
                        }).toList();

                        if (events.isEmpty) {
                          return Center(
                            child: Text(
                              "No events found for your search",
                              style: jost500(16.sp, AppColors.blueColor),
                            ),
                          );
                        }
                      }

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
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
