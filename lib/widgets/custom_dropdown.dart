import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/const/colors.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? prefixImage; // Changed from IconData? to String?
  final Color fillColor;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final double hintTextSize;
  final double iconSize;
  final ValueChanged<String?>? onChanged;

  CustomDropdownMenu({
    required this.items,
    required this.hintText,
    this.prefixImage, // Changed here
    this.fillColor = AppColors.fillcolor,
    this.borderRadius = 13.31,
    this.borderColor,
    this.borderWidth = 1.0,
    this.hintTextSize = 14,
    this.iconSize = 15.0,
    this.onChanged,
  });

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311.w,
      height: 43.75.h,
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent,
          width: widget.borderWidth,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedItem,
          hint: Row(
            children: [
              if (widget.prefixImage != null) // Check if prefixImage is not null
                Image.asset(
                  widget.prefixImage!, // Use the image asset
                  width: 17.w, // Adjust width as necessary
                  height: 17.h, // Adjust height as necessary
                ),
              SizedBox(width: 8.w),
              Text(
                widget.hintText,
                style: TextStyle(
                  color: AppColors.blueColor,
                  fontSize: widget.hintTextSize,
                  fontFamily: 'jost',
                ),
              ),
            ],
          ),
          icon: Icon(
            FontAwesomeIcons.chevronDown,
            size: widget.iconSize,
            color: AppColors.blueColor,
          ),
          isExpanded: true,
          style: TextStyle(
            color: Color.fromRGBO(19, 64, 100, 1),
            fontSize: 12.sp,
          ),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ))
              .toList(),
        ),
      ),
    );
  }
}
