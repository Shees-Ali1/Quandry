import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';

class CustomAppBarL extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onDrawerTap; // Add a callback parameter

  CustomAppBarL({required this.onDrawerTap}); // Constructor to receive the callback

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
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 48.86.h), // Top padding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Search field
                SizedBox(
                  height: 38.h,
                  width: 216.w,
                  child: TextField(
                    style: TextStyle(color: AppColors.appbartextColor),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      hintText: 'Search for event availability',
                      hintStyle: TextStyle(
                        color: AppColors.appbartextColor,
                        fontSize: 15.36.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 19.2.h,
                          width: 19.2.w,
                          child: Image.asset(
                            AppImages.search_icon,
                            color: AppColors.backgroundColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.blueColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Image.asset(
                      AppImages.profile_image_small,
                      height: 22.17.h,
                      width: 22.17.w,
                    ),
                    SizedBox(width: 20.w), // Top padding
                    /// notification Button
                    GestureDetector(
                      onTap: onDrawerTap, // Use the callback here
                      child: Image.asset(
                        AppImages.notification_icon_small,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),

              ],
            ),


          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
