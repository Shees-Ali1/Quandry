import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 34.86.w,
        height: 16.6.h,
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(216, 229, 236, 1) : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.3.h),
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isSelected ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16.6.h,
            height: 16.6.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blueColor : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
