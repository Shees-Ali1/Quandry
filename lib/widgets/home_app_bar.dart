import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:get/get.dart';

import '../Homepage/filter_home.dart';
class CustomAppBarH extends StatelessWidget implements PreferredSizeWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(height: 52.h),
            Row(
              children: [
                // Drawer Button
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
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
                        child: Image.asset(
                          AppImages.drawer_icon,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.h),
                // Search Bar
                Expanded(
                  child: Container(
                    height: 38.h,
                    child: TextField(
                      style: TextStyle(color: AppColors.blueColor),
                      decoration: InputDecoration(
                        hintText: 'Search for anything',
                        hintStyle: TextStyle(
                          color: AppColors.blueColor,
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
                              color: AppColors.blueColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.free,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.h),
                // Filter button
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    isScrollControlled: true,
                    builder: (_) => FilterContent(),
                  ),
                  child: Container(
                    height: 38.h,
                    width: 62.w,
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    decoration: BoxDecoration(
                      color: AppColors.free,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.filter,
                          color: AppColors.blueColor,
                          height: 15.75.h,
                          width: 13.33.w,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: AppColors.blueColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
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

// class CustomAppBarH extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Container(
//         height: 100.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: AppColors.blueColor, // Customize the color as needed
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(15.r),
//             bottomRight: Radius.circular(15.r),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           child: Column(
//             children: [
//               SizedBox(height: 52.h),
//               Row(
//                 children: [
//                   // Drawer Button
//                   GestureDetector(
//                     onTap: () {
//                       Scaffold.of(context).openDrawer(); // Opens the drawer
//                     },
//                     child: Container(
//                       height: 36.28.h,
//                       width: 36.28.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.blueColor,
//                         border: Border.all(color: AppColors.backgroundColor),
//                       ),
//                       child: Center(
//                         child: Container(
//                           height: 12.03.h,
//                           width: 21.43.w,
//                           child: Image.asset(
//                             AppImages.drawer_icon,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.h),
//                   // Search Bar
//                   Container(
//                     height: 38.h,
//                     width: 216.w,
//                     child: TextField(
//                       style: TextStyle(color: AppColors.appbartextColor),
//                       // Sets the text color
//                       decoration: InputDecoration(
//                         hintText: 'Search for anything',
//                         hintStyle: TextStyle(
//                           color: AppColors.blueColor,
//                           fontSize: 15.36.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         // Sets hint text color
//                         prefixIcon: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           // Adjust padding around the image as needed
//                           child: Container(
//                             height: 19.2.h,
//                             width: 19.2.w,
//                             child: Image.asset(
//                               AppImages.search_icon,
//                               // Replace with your image path
//                               color: AppColors.blueColor,
//                               // Applies color to image if needed
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: AppColors.free,
//                         // Sets background color
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.r),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 4.0.h), // Adjust padding as needed
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.h),
//                   // Filter button
//                   GestureDetector(
//                     onTap: () => showModalBottomSheet(
//                       context: context,
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//                       ),
//                       isScrollControlled: true,
//                       builder: (_) => FilterContent(),
//                     ),
//                     child: Container(
//                       height: 38.h,
//                       width: 62.w,
//                       padding: EdgeInsets.symmetric(horizontal: 7.w),
//                       // Center padding for text and icon
//                       decoration: BoxDecoration(
//                         color: AppColors.free, // Background color
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             AppImages.filter, // Path to your asset image
//                             color: AppColors.blueColor, // Apply color if needed
//                             height: 15.75.h, // Match icon size
//                             width: 13.33.w,
//                           ),
//                           SizedBox(width: 5.w),
//                           Text(
//                             'Filter',
//                             style: TextStyle(
//                               color: AppColors.blueColor, // Text color
//                               fontSize: 11.sp, // Text size to match design
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(65.h);
// }