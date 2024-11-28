import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:intl/intl.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final List eventDates;  // Receive event dates from the parent

  CustomCalendar({super.key, required this.eventDates});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ProfileController profileVM = Get.put(ProfileController());

  int? selectedDate; // Variable to hold the selected date
  DateTime currentMonth = DateTime.now(); // Keeps track of the displayed month
  DateTime today = DateTime.now(); // Current date

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay; // For single-day selection
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  Map<String, int> eventCounts = {};
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    // Set the initially selected date to today's date
    selectedDate = today.day;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update your reactive list or state here
      formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (!profileVM.selectedCalenderDate.contains(formattedDate)) {
        profileVM.selectedCalenderDate.add(formattedDate);
      }
    });


    // Debug output of the passed eventDates
    print(widget.eventDates);
  }

  @override
  Widget build(BuildContext context) {
    // Format the month name
    String monthName = DateFormat('MMMM').format(currentMonth);

    // Clear the event counts before adding new ones
    eventCounts.clear();
    for (var eventDay in widget.eventDates) {
      String eventDate = DateFormat('yyyy-MM-dd').format(DateTime(today.year, today.month, eventDay));
      eventCounts[eventDate] = (eventCounts[eventDate] ?? 0) + 1;
    }

    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: TableCalendar(
        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime(2050, 12, 31),
        focusedDay: _focusedDay,
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        currentDay: _selectedDay,
        selectedDayPredicate: (day) =>
            isSameDay(_selectedDay, day), // Highlight for single-day selection
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _rangeStart = start;
            _rangeEnd = end;
            _focusedDay = focusedDay;
            _selectedDay = null; // Clear single selection when range is selected
          });

          profileVM.selectedCalenderDate.clear();


          if (start != null && end != null) {
            DateTime currentDate = start;
            while (!currentDate.isAfter(end)) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
              profileVM.selectedCalenderDate.add(formattedDate);
              currentDate = currentDate.add(Duration(days: 1)); // Move to the next day
            }
            print(profileVM.selectedCalenderDate); // Debugging output
          } else if(start != null && end == null){
            String formattedDate = DateFormat('yyyy-MM-dd').format(start);

            // Check if the date is not already in the list and add it
            profileVM.selectedCalenderDate.clear();

            if (!profileVM.selectedCalenderDate.contains(formattedDate)) {
              profileVM.selectedCalenderDate.add(formattedDate);  // Add the selected date
            }
          }
        },
        // onDaySelected: (selectedDay, focusedDay) {
        //   setState(() {
        //     // Set the focusedDay to the selected day if it's not today
        //     if (!isSameDay(selectedDay, today)) {
        //       _focusedDay = selectedDay; // Update focusedDay
        //     }
        //
        //     _selectedDay = selectedDay;
        //     _rangeStart = null; // Clear range when single day is selected
        //     _rangeEnd = null;
        //   });
        //
        //   // Format the selected date
        //   String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
        //
        //   // Check if the date is not already in the list and add it
        //   profileVM.selectedCalenderDate.clear();
        //
        //   if (!profileVM.selectedCalenderDate.contains(formattedDate)) {
        //       profileVM.selectedCalenderDate.add(formattedDate);  // Add the selected date
        //   }
        //
        //   print(profileVM.selectedCalenderDate);
        // },
        calendarStyle: CalendarStyle(
          // cellMargin: EdgeInsets.only(top: 10),
          selectedDecoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
          canMarkersOverflow: false,
          cellPadding: EdgeInsets.zero,
          cellAlignment: Alignment.bottomCenter,
          selectedTextStyle: jost400(14.sp, AppColors.blueColor),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.6,
              color: AppColors.secondaryColor,
            ),
          ),
          todayTextStyle: jost400(15.sp, AppColors.secondaryColor),
          rangeHighlightColor: AppColors.secondaryColor.withOpacity(0.5),
          rangeStartDecoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: AppColors.secondaryColor,
            shape: BoxShape.circle,
          ),
          rangeStartTextStyle: jost400(15.sp, AppColors.blueColor),
          rangeEndTextStyle: jost400(15.sp, AppColors.blueColor),
          defaultTextStyle: jost400(15.sp, AppColors.secondaryColor),
          outsideDaysVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: jost700(13.sp, AppColors.secondaryColor),
          weekendStyle: jost700(13.sp, AppColors.secondaryColor),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: jost700(13.sp, AppColors.secondaryColor),
          leftChevronIcon: Icon(
            CupertinoIcons.left_chevron,
            size: 20.w,
            color: AppColors.secondaryColor,
          ),
          rightChevronIcon: Icon(
            CupertinoIcons.right_chevron,
            size: 20.w,
            color: AppColors.secondaryColor,
          ),
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        rowHeight: 35,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
            final eventCount = eventCounts[formattedDate];

            return Container(
              height: 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: jost400(14.sp, AppColors.secondaryColor),
                  ),
                  if (eventCount != null && eventCount > 0)
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '($eventCount)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
