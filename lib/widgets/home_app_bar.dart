import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:get/get.dart';

import '../Homepage/filter_home.dart';
import '../profile_screen/user_profile.dart';


class CustomAppBarH extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarHState createState() => _CustomAppBarHState();

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}

class _CustomAppBarHState extends State<CustomAppBarH> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

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
                // Search Bar
                Expanded(
                  child: Container(
                    height: 38.h,
                    child: TextField(
                      controller: _searchController,
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
            SizedBox(height: 10.h),
            if (_searchController.text.isNotEmpty)
              _buildStaticUserSearchResult(context),
          ],
        ),
      ),
    );
  }


  Widget _buildStaticUserSearchResult(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Get.to(UserProfilePage(navbar: false,));
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            // Static user avatar
            Padding(
              padding: EdgeInsets.all(10.w),
              child: CircleAvatar(
                radius: 20.w,
                backgroundImage: AssetImage(
                  'assets/images/headshot.jpg',
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Static username
            Text(
              '@ali_321',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
