import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:csc_picker/csc_picker.dart';
import '../const/images.dart';
import 'package:intl/intl.dart';

class FilterContent extends StatefulWidget {
  @override
  _FilterContentState createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  final Homecontroller homeVM = Get.find<Homecontroller>();

  int selectedIndex = -1;
  int _number = 56;
  bool isIncrementSelected = false; // Track which arrow is selected


  void _openLocationPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                CSCPicker(
                  layout: Layout.vertical,
                  flagState: CountryFlag.DISABLE,
                  showStates: true, // Enable state picker
                  showCities: true, // Enable city picker
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    border: Border.all(color: AppColors.blueColor),
                  ),
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    border: Border.all(color: AppColors.blueColor),
                  ),
                  searchBarRadius: 16,
                  onCountryChanged: (value) {
                      homeVM.country.value = value;
                      homeVM.state.value = "Select State"; // Reset state when country changes
                      homeVM.city.value = "Select City"; // Reset city when country changes
                  },
                  onStateChanged: (value) {
                      homeVM.state.value = value ?? "Select State";
                      homeVM.city.value = "Select City"; // Reset city when state changes
                  },
                  onCityChanged: (value) {
                      homeVM.city.value = value ?? "Select City";
                  },
                ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text("Confirm"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to open the date picker dialog
  Future<void> _openDatePickerDialog() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: homeVM.date_time.value, // Initialize with the current value
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: AppColors.blueColor,
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: AppColors.greenbutton,
              onPrimary: AppColors.blueColor,
              secondary: AppColors.greenbutton,
              onSecondary: AppColors.greenbutton,
              error: Colors.red,
              onError: Colors.red,
              surface: AppColors.blueColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    // Check if the picked date is not null and if it's different from the current value
    if (picked != null ) {
      // Update the homeVM.date_time.value to the selected date
      homeVM.date_time.value = picked;
      homeVM.date_selected.value = true;
      homeVM.tapped_date.value = "";

      // Print the updated date
      print(homeVM.date_time.value);
    }
  }

  @override
  void dispose(){
    super.dispose();
    setState(() {

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
                  Navigator.pop(context);

                  FocusScope.of(context).unfocus();
                  homeVM.date_selected.value = false;
                  homeVM.filter_topics.clear();
                  homeVM.country.value = homeVM.currentCountry.value;
                  homeVM.city.value = homeVM.currentCity.value;
                  homeVM.state.value = "";
                  homeVM.tapped_date.value = "";
                  homeVM.selected_from_price.value = 0;
                  homeVM.selected_to_price.value = 500;
                  homeVM.filter.value = false;


                  setState(() {

                  });
                  setState(() {

                  });setState(() {

                  });
                  setState(() {

                  });
                  setState(() {

                  });
                  setState(() {

                  });
                },
                width: 112.w,
                textColor: AppColors.blueColor,
                fontSize: 13.sp,

              ),
              SizedBox(width: 20.w), // Add spacing between buttons
              CustomButton(
                text: 'APPLY',
                color: AppColors.blueColor,
                onPressed: () {
                  homeVM.filter.value = true;


                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();


                  setState(() {

                  });
                  setState(() {

                  });setState(() {

                  });
                  setState(() {

                  });
                  setState(() {

                  });
                },
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
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
            },
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
    return Obx(
      ()=> Column(
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
              // bool isSelected = homeVM.filter_topics.contains(topic);
              return GestureDetector(
                onTap: () {
                 if(homeVM.filter_topics.contains(topic)){
                   homeVM.filter_topics.remove(topic);
                 } else {
                   homeVM.filter_topics.add(topic);
                 }
                 debugPrint(homeVM.filter_topics.toString());
                },
                child: _buildTopicChip(topic, homeVM.filter_topics.contains(topic)),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildTopicChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.appbar_text : AppColors.appbar_text,
        gradient: isSelected
            ? LinearGradient(colors: [Color(0xFF0D2D3F), Color(0xFF3C657D)])
            : null,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: !isSelected ? AppColors.blueColor : AppColors.backgroundColor,
          fontWeight: !isSelected ? FontWeight.w400 : FontWeight.w600,
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
    return GestureDetector(
      onTap: () {

        if(index == 0){
          homeVM.tapped_date.value = "Today";
        } else if(index == 1){
          homeVM.tapped_date.value = "Tomorrow";
        } else {
          homeVM.tapped_date.value = "This week";
        }

        homeVM.date_selected.value = false;
        debugPrint(homeVM.tapped_date.value);
      },
      child: Obx(
        ()=> Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: homeVM.tapped_date.value == label ? AppColors.appbar_text : AppColors.appbar_text,
            gradient: homeVM.tapped_date.value == label
                ? LinearGradient(colors: [Color(0xFF0D2D3F), Color(0xFF3C657D)])
                : null,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: homeVM.tapped_date.value == label ?  AppColors.backgroundColor : AppColors.blueColor ,
                fontWeight: homeVM.tapped_date.value == label ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSelector() {
    return GestureDetector(
      onTap: (){
        _openDatePickerDialog();
      },
      child: Container(
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
            Obx(
                ()=> Expanded(
                  child: homeVM.date_selected.value
                      ? Text(DateFormat('dd/MM/yyyy').format(homeVM.date_time.value), style: jost400(13.sp, AppColors.blueColor),)
                      : Text('Choose from calendar', style: jost400(13.sp, AppColors.blueColor))),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: jost600(13.sp, AppColors.blueColor)),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: (){
            _openLocationPickerDialog();
          },
          child: Container(
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
                Obx(
                    ()=> Expanded(
                      child: Text('${homeVM.city.value}, ${homeVM.country.value}',
                          style: jost400(12.sp, AppColors.blueColor))),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 18.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select price range',
                  style: jost600(12.sp, AppColors.blueColor)),
              Text('\$${homeVM.selected_from_price.value} - \$${homeVM.selected_to_price.value}', style: jost600(12.sp, AppColors.blueColor)),
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
                Text('${homeVM.selected_from_price.value}', style: jost500(18.94.sp, AppColors.blueColor)),
                Spacer(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: homeVM.incrementFromPrice,
                      child: Icon(
                        Icons.arrow_drop_up_sharp,
                        size: 24.0,
                        color: homeVM.increment_for_from.value
                            ? AppColors.blueColor
                            : AppColors.appbar_text,
                      ),
                    ),
                    GestureDetector(
                      onTap: homeVM.decrementFromPrice,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 24.0,
                        color: !homeVM.increment_for_from.value
                            ? AppColors.blueColor
                            : AppColors.appbar_text,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.only(left: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 1.w, color: AppColors.border),
            ),
            child: Row(
              children: [
                Text('${homeVM.selected_to_price.value}', style: jost500(18.94.sp, AppColors.blueColor)),
                Spacer(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: homeVM.incrementToPrice,
                      child: Icon(
                        Icons.arrow_drop_up_sharp,
                        size: 24.0,
                        color: homeVM.increment_for_to.value
                            ? AppColors.blueColor
                            : AppColors.appbar_text,
                      ),
                    ),
                    GestureDetector(
                      onTap: homeVM.decrementToPrice,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 24.0,
                        color: !homeVM.increment_for_to.value
                            ? AppColors.blueColor
                            : AppColors.appbar_text,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [],
    );
  }
}
