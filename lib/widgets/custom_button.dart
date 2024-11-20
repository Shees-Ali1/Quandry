import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double? width; // Optional width parameter
  final Color? textColor; // Optional text color parameter
  final double? fontSize; // Optional font size parameter

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width, // Initialize optional width
    this.textColor, // Initialize optional text color
    this.fontSize, // Initialize optional font size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: width ?? double.infinity, // Use provided width or default to double.infinity
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
          style: TextStyle(
            fontSize: fontSize?.sp ?? 19.sp, // Use provided font size or default to 19.sp
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.backgroundColor, // Use provided text color or default
          ),
        ),
      ),
    );
  }
}
