import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';

class CustomAppBarL extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 167.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.blueColor, // Customize the color as needed
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
                Container(
                  height: 36.28.h,
                  width: 36.28.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  AppColors.blueColor,
                    border: Border.all(color: AppColors.backgroundColor)
                  ),
                  child: Center(
                    child: Container(
                      height: 12.03.h,
                      width: 21.43.w,
                      child: Image.asset(
                        AppImages.drawer_icon,
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
                    Image.asset(
                      AppImages.notification_icon_small,
                      height: 19.h,
                      width: 19.w,
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 19.86.h),
            /// Search field
            SizedBox(
              height: 38.h, // Sets the height to 38.h
              child: TextField(
                style: TextStyle(color: AppColors.appbartextColor), // Sets the text color
                textAlignVertical: TextAlignVertical.center, // Centers the text vertically
                decoration: InputDecoration(
                  isDense: true, // Reduces the default internal padding
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h), // Adjusts vertical padding
                  hintText: 'Search for event availability',
                  hintStyle: TextStyle(
                    color: AppColors.appbartextColor,
                    fontSize: 15.36.sp,
                    fontWeight: FontWeight.w400,
                  ), // Sets hint text color
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8.0), // Adjust padding around the image as needed
                    child: Container(
                      height: 19.2.h,
                      width: 19.2.w,
                      child: Image.asset(
                        AppImages.search_icon, // Replace with your image path
                        color: AppColors.backgroundColor, // Applies color to image if needed
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.blueColor, // Sets background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(167.h);
}
