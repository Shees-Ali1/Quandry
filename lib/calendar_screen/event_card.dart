import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/calendar_screen/event_details.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventCard extends StatelessWidget {
  final String imageAsset; // Change this to imageAsset
  final String title;
  final String date;
  final String location;
  final String credits;
  final String priceRange;
  final QueryDocumentSnapshot<Object?>? event;

  const EventCard({
    Key? key,
    required this.imageAsset, // Update constructor parameter
    required this.title,
    required this.date,
    required this.location,
    required this.credits,
    required this.priceRange, required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h, // Increased height for better spacing
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0.w), // Increased overall padding
            child: Row(
              children: [
                /// Main Image on the Left
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0.r), // Slightly larger radius
                  child: Container(
                    height: double.infinity, // Use responsive height
                    width: 150.w, // Adjusted width for image
                    child: Image.network(
                      imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w), // Increased spacing between image and text
                /// Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Title and Bookmark Icon
                      SizedBox(
                        width: 140.w,
                        child: Text(
                          title,
                          style: jost700(12.sp, AppColors.backgroundColor), // Slightly larger font
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.h), // Added spacing between title and other elements

                      /// Date and Location Row
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendar, size: 14.0.sp, color: AppColors.backgroundColor),
                          SizedBox(width: 6.w),
                          Text(
                            date,
                            style: jost600(11.sp, AppColors.backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14.0, color: AppColors.backgroundColor),
                          SizedBox(width: 6.w),
                          Text(
                            location,
                            style: jost600(11.sp, AppColors.backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.bookOpen,
                            size: 12.0,
                            color: AppColors.backgroundColor,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            credits,
                            style: jost600(11.sp, AppColors.backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.tag, size: 14.0, color: AppColors.backgroundColor),
                          SizedBox(width: 6.w),
                          Text(
                            priceRange,
                            style: jost600(11.sp, AppColors.backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      /// View Button
                      SizedBox(
                        width: 100.w,
                        height: 28.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => EventDetail(event: event!,));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fillcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              fontFamily: "Jost",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Bookmark Icon
        Positioned(
          right: 0.w,
          top: 0.h,
          child: GestureDetector(
            onTap: () {
              print('Bookmark tapped!');
            },
            child: Container(
              height: 28.h,
              width: 28.w,
              decoration: BoxDecoration(
                color: AppColors.eventcard_label,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Center(
                child: Image.asset(
                  AppImages.Bookmark,
                  height: 18.h,
                  width: 18.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
