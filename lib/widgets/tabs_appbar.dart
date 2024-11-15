import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';

import '../Homepage/filter_home.dart';

class TabsAppBar extends StatelessWidget implements PreferredSizeWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(height: 48.86.h), // Top padding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Search field
                Container(
                  height: 38.h,
                  width: 255.w,
                  child: TextField(
                    style: TextStyle(color: AppColors.appbartextColor),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                      hintText: 'Search for anything',
                      hintStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14.36.sp,
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
                      suffixIcon: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                          ),
                          isScrollControlled: true,
                          builder: (_) => FilterContent(),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w,top: 5.h,bottom: 5.h,left: 7.w),
                          child: Container(
                            width: 8.w,
                            decoration: BoxDecoration(
                              color: AppColors.free,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.filter,
                                  color: AppColors.blueColor,
                                  height: 13.h,
                                  width: 13.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(50, 82, 98, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    /// notification Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: Image.asset(
                          AppImages.notification_icon_small,
                          height: 25.h,
                          width: 25.w,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w), // Top padding

                    Image.asset(
                      AppImages.profile_image_small,
                      height: 27.h,
                      width: 27.w,
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
