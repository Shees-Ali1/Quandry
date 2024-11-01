import 'package:flutter/material.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AttendingScreenMain extends StatefulWidget {
  const AttendingScreenMain({super.key});

  @override
  State<AttendingScreenMain> createState() => _AttendingScreenMainState();
}

class _AttendingScreenMainState extends State<AttendingScreenMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey, // Assign the scaffold key
        appBar: AppbarSmall(
        title: "Attending", // Set the title for the app bar
        iconImage: AppImages.drawer_icon, // Set your custom back icon
        onIconTap: () {
      _scaffoldKey.currentState?.openDrawer(); // Open drawer on icon tap
    },),
    backgroundColor: AppColors.backgroundColor,
    drawer: MyDrawer(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Text("No Data Available",style: jost700(18.sp, AppColors.blueColor),))
        ],
      ),
    );
  }
}
