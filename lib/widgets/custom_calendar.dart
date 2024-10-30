import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int? selectedDate; // Variable to hold the selected date
  List<bool> buttonStates = [false, false, false]; // State for bottom buttons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        Container(
        height: 240.h,
        decoration: BoxDecoration(
          color: AppColors.fillcolor,
          borderRadius: BorderRadius.circular(11.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Adjust shadow color and opacity
              blurRadius: 8.r, // Softness of the shadow
              spreadRadius: 2.r, // Extent of the shadow
              offset: Offset(0, 4), // Horizontal and vertical offset of the shadow
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
                            "February",
                            style: jost500(8.88.sp, AppColors.blueColor),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, size: 12.w, color: AppColors.iconcolorcalendar),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.8.h),

                  /// Day Labels Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:12.w ),
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
                        childAspectRatio: 32.13 / 20.27, // Set this ratio based on your desired width/height                  crossAxisSpacing: 2.w,
                        mainAxisSpacing: 5.h,
                        crossAxisSpacing: 10.w
                      ),
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedDate == index + 1; // Check if date is selected
                        return  GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = index + 1; // Update selected date
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.blueColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.08.r),
                              border: Border.all(
                                color: AppColors.calendar_border,
                              ),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: jost600(
                                8.86.sp,
                                isSelected ? AppColors.fillcolor : AppColors.calendardidigts, // Change color if selected
                              ),
                            ),
                          ),
                        );


                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 13.h),
          /// Bottom Buttons Row
          Container(
            height: 65.37.h,
            decoration: BoxDecoration(
              color: AppColors.fillcolor,
              borderRadius: BorderRadius.circular(11.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Adjust shadow color and opacity
                  blurRadius: 8.r, // Softness of the shadow
                  spreadRadius: 2.r, // Extent of the shadow
                  offset: Offset(0, 4), // Horizontal and vertical offset of the shadow
                ),
              ],
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomButton(
                    title: "Today, 23 Mar",
                    subtitle: "No event",
                    isSelected: buttonStates[0],
                    onTap: () {
                      setState(() {
                        buttonStates[0] = !buttonStates[0]; // Toggle selection
                      });
                    },
                  ),
                  _buildBottomButton(
                    title: "Tomorrow, 24 Mar",
                    subtitle: "Available",
                    isSelected: buttonStates[1],
                    onTap: () {
                      setState(() {
                        buttonStates[1] = !buttonStates[1]; // Toggle selection
                      });
                    },
                  ),
                  _buildBottomButton(
                    title: "Thu, 25 Mar",
                    subtitle: "Available",
                    isSelected: buttonStates[2],
                    onTap: () {
                      setState(() {
                        buttonStates[2] = !buttonStates[2]; // Toggle selection
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap, // Added onTap parameter
  }) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function when the button is tapped
      child: Container(
        height: 33.63.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueColor: AppColors.fillcolor,
          borderRadius: BorderRadius.circular(8.31.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Adjust shadow color and opacity
              blurRadius: 8.r, // Softness of the shadow
              spreadRadius: 2.r, // Extent of the shadow
              offset: Offset(0, 4), // Horizontal and vertical offset of the shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: jost700(
                  9.34.sp,
                  isSelected ? Colors.white : AppColors.calendartext, // Change color if selected
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: jost600(
                  6.23.sp,
                  isSelected ? Colors.white : AppColors.blueColor, // Change color if selected
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
