import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:get/get.dart';


import '../const/images.dart';

class FilterContent extends StatefulWidget {
  @override
  _FilterContentState createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  int selectedIndex = -1;
  int _number = 56;
  bool isIncrementSelected = false; // Track which arrow is selected
  Set<String> selectedTopics = {'Substance Abuse', 'Yoga', 'Social Life'};

  void _incrementNumber() {
    setState(() {
      _number++;
      isIncrementSelected = true;
    });
  }

  void _decrementNumber() {
    setState(() {
      _number--;
      isIncrementSelected = false;
    });
  }

  // void _incrementNumber() => setState(() => _number++);
  // void _decrementNumber() => setState(() => _number > 0 ? _number-- : null);
  bool isUpArrowClicked = false;

  void _toggleUpArrow() {
    setState(() {
      isUpArrowClicked = true;
    });
  }

  void _toggleDownArrow() {
    setState(() {
      isUpArrowClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 20.h),
          _buildTopicSection(),
          SizedBox(height: 20.h),
          _buildTimeDateSection(),
          SizedBox(height: 20.h),
          _buildLocationSection(),
          SizedBox(height: 20.h),
          _buildPriceSection(),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space evenly between buttons
            children: [
              CustomButton(
                text: 'CANCEL',
                color: AppColors.appbar_text,
                onPressed: () {
                  Get.back();
                },
                width: 112.w,
                textColor: AppColors.blueColor,
                fontSize: 13.sp,

              ),
              SizedBox(width: 20.w), // Add spacing between buttons
              CustomButton(
                text: 'APPLY',
                color: AppColors.blueColor,
                onPressed: () {},
                width: 160.w,
                textColor: AppColors.backgroundColor,
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Filter', style: jost600(19.sp, AppColors.blueColor)),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.blueColor),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildTopicSection() {
    List<String> topics = [
      'Substance Abuse',
      'Addiction Treatment',
      'Events',
      'Sports',
      'Trips',
      'Yoga',
      'Social Life'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Topics', style: jost600(12.sp, AppColors.blueColor)),
        SizedBox(height: 10.h),
        // Wrap(
        //   spacing: 10.w,
        //   runSpacing: 10.h,
        //   children: topics.map((topic) {
        //     bool isSelected = topic == 'Substance Abuse' ||
        //         topic == 'Yoga' ||
        //         topic == 'Social Life';
        //     return _buildTopicChip(topic, isSelected);
        //   }).toList(),
        // ),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: topics.map((topic) {
            bool isSelected = selectedTopics.contains(topic);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedTopics.remove(topic);
                  } else {
                    selectedTopics.add(topic);
                  }
                });
              },
              child: _buildTopicChip(topic, isSelected),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildTopicChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.appbar_text : Colors.pinkAccent,
        gradient: !isSelected
            ? LinearGradient(colors: [Color(0xFF0D2D3F), Color(0xFF3C657D)])
            : null,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: isSelected ? AppColors.blueColor : AppColors.backgroundColor,
          fontWeight: isSelected ? FontWeight.w400 : FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimeDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Time & Date', style: jost600(12.sp, AppColors.blueColor)),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Today', 'Tomorrow', 'This week']
              .asMap()
              .entries
              .map((entry) => _buildSelectableContainer(entry.value, entry.key))
              .toList(),
        ),
        SizedBox(height: 18.65.h),
        _buildCalendarSelector(),
      ],
    );
  }

  Widget _buildSelectableContainer(String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.appbar_text : Colors.transparent,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.blueColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.94.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.calenderr,
            height: 36.h,
            width: 36.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
              child: Text('Choose from calendar',
                  style: jost400(13.sp, AppColors.blueColor))),
          Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: jost600(13.sp, AppColors.blueColor)),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.94.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Image.asset(
                AppImages.locationnew,
                height: 36.h,
                width: 36.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                  child: Text('New York, USA',
                      style: jost400(12.sp, AppColors.blueColor))),
              Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 18.sp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select price range',
                style: jost600(12.sp, AppColors.blueColor)),
            Text('\$20 - \$120', style: jost600(12.sp, AppColors.blueColor)),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(width: 1.w, color: AppColors.border),
          ),
          child: Row(
            children: [
              Text('$_number', style: jost500(18.94.sp, AppColors.blueColor)),
              Spacer(),
              Column(
                children: [
                  GestureDetector(
                    onTap: _incrementNumber,
                    child: Icon(
                      Icons.arrow_drop_up_sharp,
                      size: 24.0,
                      color: isIncrementSelected
                          ? AppColors.blueColor
                          : AppColors.appbar_text,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementNumber,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 24.0,
                      color: !isIncrementSelected
                          ? AppColors.blueColor
                          : AppColors.appbar_text,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [],
    );
  }
}
