import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';

class CustomTextField1 extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? obscuringCharacter; // Nullable to handle non-password fields
  final double hintTextSize;
  final Color fillColor; // Fill color
  final double borderRadius; // Border radius
  final Color? borderColor; // Custom border color
  final double borderWidth; // Custom border width

  CustomTextField1({
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter,
    this.hintTextSize = 14,
    this.fillColor = const Color.fromRGBO(245, 251, 254, 1), // Default fill color
    this.borderRadius = 13.31, // Default radius
    this.borderColor, // Default to null
    this.borderWidth = 1.0, // Default border width
  });


  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField1> {
  late bool _obscureText;
  late String? _obscuringCharacter;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _obscuringCharacter = widget.obscuringCharacter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 311.w,
      height: 43.75.h,
      decoration: BoxDecoration(
        color: widget.fillColor, // Keep the specified fill color
        borderRadius: BorderRadius.circular(widget.borderRadius), // Keep the specified radius
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent, // Default to transparent if no color is specified
          width: widget.borderWidth,
        ),
      ),
      child: TextField(
        obscureText: _obscureText,
        obscuringCharacter: _obscuringCharacter ?? '*',

        style: TextStyle(color: Color.fromRGBO(19, 64, 100, 1),fontSize: 14.sp),
        decoration: InputDecoration(
          filled: false, // No additional filling from InputDecoration
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.blueColor,
            fontWeight: FontWeight.w400,
            fontSize: widget.hintTextSize,
            fontFamily: 'jost',
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Color.fromRGBO(19, 64, 100, 1),
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color.fromRGBO(19, 64, 100, 1),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          border: InputBorder.none, // No border until specified
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        ),
      ),
    );
  }
}
