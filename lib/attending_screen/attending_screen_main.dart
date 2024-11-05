import 'package:flutter/material.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendingScreenMain extends StatefulWidget {
  const AttendingScreenMain({super.key});

  @override
  State<AttendingScreenMain> createState() => _AttendingScreenMainState();
}

class _AttendingScreenMainState extends State<AttendingScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h), // Set the height of the custom app bar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back arrow
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  'Attending',
                  style: jost700(16.sp, Colors.white), // Custom font style
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "No Data Available",
              style: jost700(18.sp, AppColors.blueColor),
            ),
          ),
        ],
      ),
    );
  }
}
