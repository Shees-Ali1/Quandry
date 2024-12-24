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
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileVM = Get.put(ProfileController());
  final Homecontroller homeVM = Get.find<Homecontroller>();


  final TextEditingController _searchController = TextEditingController();

  late Future<QuerySnapshot> attending_events;

  @override
  void initState() {
    super.initState();
    profileVM.getBlockDelete();
    attending_events = fetchAttendingEvents();
  }

  Future<QuerySnapshot> fetchAttendingEvents() async {
    return FirebaseFirestore.instance.collection('events').where("attending", arrayContains: FirebaseAuth.instance.currentUser!.uid).get();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String getNearestFutureDate(List<String> dateList) {
    // Get the current date
    DateTime current = DateTime.now();

    // Convert dates to DateTime objects and filter for future dates
    List<DateTime> futureDates = dateList
        .map((date) => DateTime.parse(date))
        .where((date) => date.isAfter(current))
        .toList();

    if (futureDates.isEmpty) {
      return ''; // Return an empty string if no future dates exist
    }

    // Find the nearest future date
    futureDates.sort((a, b) => a.compareTo(b));
    return futureDates.first.toIso8601String().split('T').first;
  }

  int _getTotalCredits(List ceCreditsList) {
    int credits = 0;

    // Loop through the list and sum up all the credits_earned
    for (var item in ceCreditsList) {
      credits += (item['credits_earned'] as num?)?.toInt() ?? 0;
    }

    // Update the state with the total credits
    return credits;
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    if(profileVM.is_deleted.value != true)
                    FutureBuilder(
                      future: attending_events,
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
                      child: Obx(
                        ()=> Text(
                        homeVM.search_fiter.value != "" ? 'Events for "${homeVM.search_fiter.value}"' : "Events",
                          style: jost700(16.37.sp, AppColors.blueColor),
                        ),
                      ),
                    ),
                    // Single Event Card (Detailed)
                    if(profileVM.is_deleted.value == false)
                      Obx((){
                      if(homeVM.filter.value == true){
                        return StatefulBuilder(
                          builder: (context, setState) {
                            // Wrap the StreamBuilder inside StatefulBuilder
                            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance.collection('events').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(color: AppColors.blueColor),
                                  );
                                } else if (snapshot.hasError) {
                                  debugPrint("Error in events stream: ${snapshot.error}");
                                  return Center(
                                    child: Text(
                                      "An Error occurred",
                                      style: jost500(16.sp, AppColors.blueColor),
                                    ),
                                  );
                                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "There are no events at the moment",
                                      style: jost500(16.sp, AppColors.blueColor),
                                    ),
                                  );
                                } else if (snapshot.connectionState == ConnectionState.none) {
                                  return Center(
                                    child: Text(
                                      "No Internet!",
                                      style: jost500(16.sp, AppColors.blueColor),
                                    ),
                                  );
                                } else {
                                  var events = snapshot.data!.docs;

                                  // Using GetX reactive variables to trigger rebuilds
                                  return Obx(() {
                                    // Apply topic filter
                                    if (homeVM.filter_topics.isNotEmpty) {
                                      events = events.where((event) {
                                        List<String> eventTopics = List<String>.from(event['event_topics']);
                                        return eventTopics.any((topic) => homeVM.filter_topics.contains(topic));
                                      }).toList();
                                    }

                                    // Apply date filter
                                    if (homeVM.tapped_date.isEmpty) {
                                      // Format homeVM.date_time.value to dd/MM/yyyy
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(homeVM.date_time.value);
                                      events = events.where((event) {
                                        String eventDate = event['event_date']; // Assuming event_date is in 'yyyy-MM-dd' format
                                        return eventDate == formattedDate;
                                      }).toList();
                                    } else {
                                      // Apply filters based on "today", "tomorrow", or "this week"
                                      DateTime today = DateTime.now();
                                      DateTime tomorrow = today.add(Duration(days: 1));

                                      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
                                      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

                                      if (today.weekday == DateTime.sunday) {
                                        endOfWeek = today;
                                      }

                                      events = events.where((event) {
                                        // Correctly parse event_date in yyyy-MM-dd format
                                        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                                        DateTime eventDate = dateFormat.parse(event['event_date']); // Parse the event date

                                        if (homeVM.tapped_date == 'Today') {
                                          return isSameDay(eventDate, today);
                                        } else if (homeVM.tapped_date == 'Tomorrow') {
                                          DateTime tomorrow = today.add(Duration(days: 1));
                                          return isSameDay(eventDate, tomorrow);
                                        } else if (homeVM.tapped_date == 'This week') {
                                          return eventDate.isAfter(startOfWeek.subtract(Duration(days: 1))) && eventDate.isBefore(endOfWeek.add(Duration(days: 1)));
                                        }
                                        return false;
                                      }).toList();
                                    }

                                    if(homeVM.city.value != "" && homeVM.country.value != ""){
                                      events.retainWhere((event)=> event["event_location"].toString() == "${homeVM.city.value}, ${homeVM.country.value}");
                                    }

                                    // Apply price range filter
                                    events = events.where((event) {
                                      double eventPrice = double.tryParse(event['event_price'].toString()) ?? 0.0;
                                      return eventPrice >= homeVM.selected_from_price.value && eventPrice <= homeVM.selected_to_price.value;
                                    }).toList();

                                    // Handle when no events match the filters
                                    if (events.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: Get.height * .24),
                                        child: Center(
                                          child: Text(
                                            "There are no events within your\nrequirements.",
                                            textAlign: TextAlign.center,
                                            style: jost500(16.sp, AppColors.blueColor),
                                          ),
                                        ),
                                      );
                                    }

                                    // Return the filtered events list in a ListView
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: events.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 10.0),
                                          child: EventCard(
                                            event: events[index],
                                            imageAsset: events[index]['event_image'],
                                            title: events[index]['event_name'],
                                            date: events[index]['event_date'],
                                            location: events[index]['event_location'],
                                            credits: '10 CE Credits',
                                            priceRange: "\$" + events[index]['event_price'].toString() + "/seat",
                                          ),
                                        );
                                      },
                                    );
                                  });
                                }
                              },
                            );
                          },
                        );
                      } else {
                        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance.collection('events').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(color: AppColors.blueColor),
                              );
                            } else if (snapshot.hasError) {
                              debugPrint("Error in events future home page: ${snapshot.error}");
                              return Center(
                                child: Text(
                                  "An Error occurred",
                                  style: jost500(16.sp, AppColors.blueColor),
                                ),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  "There are no events at the moment",
                                  style: jost500(16.sp, AppColors.blueColor),
                                ),
                              );
                            } else if (snapshot.connectionState == ConnectionState.none) {
                              return Center(
                                child: Text(
                                  "No Internet!",
                                  style: jost500(16.sp, AppColors.blueColor),
                                ),
                              );
                            } else {
                              var events = snapshot.data!.docs;



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
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: EventCard(
                                      event: events[index],
                                      imageAsset: events[index]['event_image'],
                                      title: events[index]['event_name'],
                                      date: events[index]['event_date'],
                                      location: events[index]['event_location'],
                                      credits: '10 CE Credits',
                                      priceRange: "\$" + events[index]['event_price'].toString() + "/seat",
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );

                    }
                    })
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

              Padding(
                padding: EdgeInsets.only(left: 12.w,top: 6.01.h,right: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Date/Time',
                          style: jost700(10.54.sp, AppColors.backgroundColor),
                        ),
                        SizedBox(height: 1.68.h),
                        Text(
                          event["event_date"] != "" && event["single_date"] == true
                              ? event["event_date"]
                              : getNearestFutureDate(
                            List<String>.from(event["multiple_event_dates"]),
                          ),
                          style: jost500(8.78.sp, AppColors.backgroundColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Location',
                          style: jost700(10.54.sp, AppColors.backgroundColor),
                        ),
                        SizedBox(height: 1.68.h),
                        Text(
                          event["event_location"]!,
                          style: jost500(8.78.sp, AppColors.backgroundColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Credits',
                          style: jost700(10.54.sp, AppColors.backgroundColor),
                        ),
                        SizedBox(height: 1.68.h),
                        Text(
                          _getTotalCredits(event["credits_and_topics"]).toString() + " CE",
                          style: jost500(8.78.sp, AppColors.backgroundColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               // Spacing between label and values
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
                    "\$" + event["event_price"]!.toString() + "/seat",
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