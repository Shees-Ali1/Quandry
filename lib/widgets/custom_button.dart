import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: double.infinity, // Set width to double.infinity
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.13.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:  TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500,color: AppColors.backgroundColor), // Change font size to 19
        ),
      ),
    );
  }
}
