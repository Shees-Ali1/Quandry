import 'package:flutter/material.dart';
import 'package:quandry/calendar_screen/event_card.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/widgets/appbar.dart';
import 'package:quandry/widgets/custom_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarScreenMain extends StatelessWidget {
  const CalendarScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        appBar: CustomAppBarL(),
        backgroundColor: AppColors.backgroundColor,
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
                    height: 321.h, // Set a specific height for the calendar
                    child: CustomCalendar(),
                  ),
                ),
                SizedBox(height: 18.63.h),
                Text(
                  "   5 Events Available in Tomorrow",
                  style: jost700(16.37.sp, AppColors.blueColor),
                ),
                SizedBox(height: 12.h),

                /// List of EventCards
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}