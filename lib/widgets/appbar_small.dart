import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';
import '../const/images.dart';
import '../const/textstyle.dart';

class AppbarSmall extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;

  AppbarSmall({required this.title, this.onBackPress});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: AppBar(
        automaticallyImplyLeading: false,
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
          child: Row(
            children: [
              SizedBox(width: 20.w),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                  onTap: onBackPress ?? () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5.w),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Image.asset(
                      AppImages.back_icon,
                      height: 12.h,
                      width: 13.w,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: jost700(16.sp, Colors.white),
                    ),
                  ),
                ),
              ),
              // Add a SizedBox to keep symmetry on the right side
              SizedBox(width: 43.w), // Adjust this width as necessary
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
