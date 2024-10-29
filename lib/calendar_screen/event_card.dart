import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';

class EventCard extends StatelessWidget {
  final String imageAsset;  // Change this to imageAsset
  final String title;
  final String date;
  final String location;
  final String credits;
  final String priceRange;

  const EventCard({
    Key? key,
    required this.imageAsset,  // Update constructor parameter
    required this.title,
    required this.date,
    required this.location,
    required this.credits,
    required this.priceRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 162.h,
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
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                /// Main Image on the Left
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.18.r),
                  child: Container(
                    height: double.infinity, // Use responsive height
                    width: 144.w,  // Use responsive width
                    child: Image.asset(
                      AppImages.event_card_image,
                      fit: BoxFit.cover, // This will ensure the image covers the entire area
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                /// Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Bookmark Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Event Title
                          Expanded(
                            child: Text(
                              title,
                              style: jost700(12.sp, AppColors.backgroundColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      /// Date and Location Row
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendar, size: 12.0, color: AppColors.backgroundColor),
                          SizedBox(width: 5.w),
                          Text(date,
                            style: jost600(10.sp, AppColors.backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12.0, color: AppColors.backgroundColor),
                          SizedBox(width: 5.w),
                          Text(location, style: jost600(10.sp, AppColors.backgroundColor),),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.bookOpen, // Use the Font Awesome book icon
                            size: 10.0,
                            color: AppColors.backgroundColor,
                          ),
                          SizedBox(width: 5.w),
                          Text(credits, style: jost600(10.sp, AppColors.backgroundColor),),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.ticket, size: 12.0, color: AppColors.backgroundColor),
                          SizedBox(width: 5.w),
                          Text(priceRange, style: jost600(10.sp, AppColors.backgroundColor),),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      /// View Button
                      SizedBox(
                        width: 98.w,
                        height: 24.h,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your view button logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fillcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.r),
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
          right: 0.w, // Adjusted to ensure it stays within the card
             // Position it within the card's bounds
          child: GestureDetector(
            onTap: () {
              // Add your bookmark toggle logic here
              print('Bookmark tapped!'); // Example action
            },
            child: Container(
              height: 25.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: AppColors.eventcard_label,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.87.r),
                  bottomLeft: Radius.circular(5.87.r),
                ),
              ),
              child: Center(
                child: Image.asset(AppImages.Bookmark, height: 17.h, width: 17.w,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
