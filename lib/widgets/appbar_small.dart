import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';

class AppbarSmall extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // Optional title
  final String? iconImage; // Optional icon image asset path
  final VoidCallback? onIconTap; // Optional tap callback for the icon

  const AppbarSmall({
    Key? key,
    this.title,
    this.iconImage,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(height: 48.86.h), // Top padding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Image
                if (iconImage != null) // Only display icon if iconImage is provided
                  GestureDetector(
                    onTap: onIconTap ?? () {}, // Use provided onTap or default to empty function
                    child: Container(
                      height: 36.28.h,
                      width: 36.28.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blueColor,
                        border: Border.all(color: AppColors.backgroundColor),
                      ),
                      child: Center(
                        child: Container(
                          height: 12.03.h,
                          width: 21.43.w,
                          child: Image.asset(iconImage!),
                        ),
                      ),
                    ),
                  ),
                // Title Text
                if (title != null) // Only display title if title is provided
                  Text(
                    title!,
                    style: jost700(16.sp, AppColors.appbar_text),
                  ),
                Image.asset(
                  AppImages.notification_icon_small,
                  height: 19.h,
                  width: 19.w,
                  color: AppColors.blueColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(167.h);
}
