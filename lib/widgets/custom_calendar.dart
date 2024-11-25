import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:intl/intl.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:get/get.dart';

class CustomCalendar extends StatefulWidget {
  final List eventDates;

  CustomCalendar({super.key, required this.eventDates});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ProfileController profileVM = Get.put(ProfileController());

  int? selectedDate; // Variable to hold the selected date
  DateTime currentMonth = DateTime.now(); // Keeps track of the displayed month
  DateTime today = DateTime.now(); // Current date

  @override
  void initState() {
    super.initState();
    // Set the initially selected date to today's date
    selectedDate = today.day;
  }

  @override
  Widget build(BuildContext context) {
    // Format the month name
    String monthName = DateFormat('MMMM').format(currentMonth);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          /// Calendar Container
          Container(
            height: 242.h,
            decoration: BoxDecoration(
              color: AppColors.fillcolor,
              borderRadius: BorderRadius.circular(11.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Adjust shadow color and opacity
                  blurRadius: 8.r, // Softness of the shadow
                  spreadRadius: 2.r, // Extent of the shadow
                  offset: Offset(0, 2), // Horizontal and vertical offset of the shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.53.w),
              child: Column(
                children: [
                  /// Calendar Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Calendar",
                        style: jost600(13.37.sp, AppColors.calendartext),
                      ),
                      Row(
                        children: [
                          Text(
                            monthName,
                            style: jost500(8.88.sp, AppColors.blueColor),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, size: 12.w, color: AppColors.iconcolorcalendar),
                            onPressed: () {
                              setState(() {
                                // Move to the next month
                                currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.8.h),

                  /// Day Labels Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                          .map((day) => Text(
                        day,
                        style: jost700(8.54.sp, AppColors.blueColor),
                      ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 9.85.h),

                  /// Date Grid
                  Container(
                    height: 160.h, // Define height for the grid
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(), // Keep GridView non-scrollable
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 32.13 / 20.27, // Set this ratio based on your desired width/height
                        mainAxisSpacing: 5.h,
                        crossAxisSpacing: 10.w,
                      ),
                      itemCount: DateTime(currentMonth.year, currentMonth.month + 1, 0).day, // Set itemCount based on the number of days in the month
                      itemBuilder: (context, index) {
                        int day = index + 1;
                        bool isSelected = selectedDate == day;
                        bool hasEvent = widget.eventDates.contains(day);
                        bool isToday = day == today.day; // Check if it's today's date

                        // Date should be blue if it's selected or today (with or without event)
                        bool isBlue = isSelected ;

                        // If the date is neither selected nor today but has an event, it should be green
                        bool isGreen = !isSelected && !isToday && hasEvent;

                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                // When tapped, set the selectedDate to the tapped day (if it's an event date or not)
                                selectedDate = day;
                              });

                             profileVM.getDate(selectedDate!);
                             setState(() {

                             });

                              if (hasEvent) {
                                final eventDetails = profileVM.events.firstWhere((event) {
                                  final eventDate = DateFormat('yyyy-MM-dd').parse(event["event_date"]!);
                                  return eventDate.day == day;
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(3.5),
                              decoration: BoxDecoration(
                                color: isBlue
                                    ? AppColors.blueColor // Blue color for selected or today, regardless of event
                                    : isGreen
                                    ? AppColors.greenbutton // Green color for event dates that are neither selected nor today
                                    : Colors.white, // Default white color for other dates
                                border: Border.all(
                                  color: isSelected || isToday
                                      ? AppColors.blueColor // Border for selected or today date
                                      : Colors.grey, // Grey border for other dates
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "$day",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isBlue || isGreen
                                        ? Colors.white // White text for selected, today, or event dates
                                        : Colors.black, // Black text for other dates
                                  ),
                                ),
                              ),
                            )

                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}