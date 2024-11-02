import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';

import '../Drawer/drawer.dart';
import '../calendar_screen/event_card.dart';
import '../const/images.dart';
import '../widgets/appbar.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Sample data for the events
  final List<Map<String, String>> events = [
    {
      "title": "California Art Festival 2024",
      "location": "Dana Point, CA",
      "date": "Oct 23-25 10PM",
      "credits": "10 CE",
      "price": "Free - \$500/seat",
    },
    {
      "title": "Utah Fall Conference on Substance Use",
      "location": "St. George, UT",
      "date": "Oct 23-25, 2024",
      "credits": "10 CE Credits",
      "price": "Free - \$500/seat",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarH(),

      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: ListView(
          children: [
            // Section Title - Attending
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                "Attending",
                style: jost700(16.37.sp, AppColors.blueColor),
              ),
            ),
            // ListView.builder for Event Cards
            SizedBox(
              height: 148.h,// Adjusted width for better match
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return _buildEventCard(events[index]);
                },
              ),
            ),
            // Section Title - Events
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                "Events",
                style: TextStyle(
                  fontSize: 16.37.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Single Event Card (Detailed)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true,
              itemCount: 2, // Number of events you want to display
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.0), // Adjust the space between items
                  child: EventCard(
                    imageAsset: AppImages.event_card_image, // Use imageAsset instead of imageUrl
                    title: 'Utah Fall Conference on Substance Use',
                    date: 'Oct 23-25, 2024',
                    location: 'St. George, UT',
                    credits: '10 CE Credits',
                    priceRange: 'Free - \$500/seat',
                  ),
                );
              },
            ),          ],
        ),
      ),
    );
  }

  // Widget to build a horizontal event card
  Widget _buildEventCard(Map<String, String> event) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        width: 223.w,
        height: 120.h, // Fixed height for the card
        child: Stack(
          children: [
            // Main Card Content (Background with Title and Event Info)
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for Image + Title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Image (Placeholder)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          AppImages.event_card_image
                          ,width: 42.39.w,
                          height: 41.27.h,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: 12.w), // Spacing between image and text

                      // Event Title
                      Expanded(
                        child: Text(
                          event["title"]!,
                          style: jost700(10.54.sp, AppColors.backgroundColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h), // Spacing below title

                  // Row for Labels (Date/Time, Location, Credits)
                  Row(
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
                  SizedBox(height: 8.h), // Spacing between label and values

                  // Row for Values (Date, Location, Credits)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event["date"]!,
                        style: jost500(8.78.sp, AppColors.backgroundColor),
                      ),
                      Text(
                        event["location"]!,
                        style: jost500(8.78.sp, AppColors.backgroundColor),
                      ),
                      Text(
                        event["credits"]!,
                        style: jost500(8.78.sp, AppColors.backgroundColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price Tag aligned at the bottom-center inside the Stack
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 145.w,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(

                  color:AppColors.free,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r), // Top-left corner radius
                    topRight: Radius.circular(12.r), // Top-right corner radius
                    bottomLeft: Radius.zero,         // Bottom-left corner with no radius
                    bottomRight: Radius.zero,        // Bottom-right corner with no radius
                  ),                ),
                child: Text(
                  event["price"]!,
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


  Widget _buildDetailedEventCard(Map<String, String> event) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            // Event Image Placeholder
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey[300],
              ),
            ),
            SizedBox(width: 12.w),
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event["title"]!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    event["location"]!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    event["date"]!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    event["credits"]!,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    event["price"]!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  ),
                ],
              ),
            ),
            // View Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                "View",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
