import 'package:flutter/material.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/tabs_appbar.dart';

class AttendingScreenMain extends StatefulWidget {
  const AttendingScreenMain({super.key});

  @override
  State<AttendingScreenMain> createState() => _AttendingScreenMainState();
}

class _AttendingScreenMainState extends State<AttendingScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabsAppBar(),
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
