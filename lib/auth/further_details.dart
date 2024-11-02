import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:quandry/widgets/custom_dropdown.dart';
import 'package:quandry/widgets/custom_textfield.dart';
import 'package:quandry/widgets/forget_back_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../const/images.dart';
import 'package:get/get.dart';

import '../widgets/custom_text.dart';

class FurtherDetails extends StatelessWidget {
  const FurtherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
      Container(
        color: AppColors.backgroundColor, // Set the background color to black
        padding: EdgeInsets.all(16.w), // Optional padding for better spacing
        child: Column(

          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.bigArrow,
                    color: AppColors.blueColor,
                    scale: 1.5,
                  ),
                  Image.asset(
                    AppImages.bigArrow,
                    color: AppColors.blueColor,
                    scale: 3,
                  ),
                  CustomText(
                    text: "  Back",
                    textColor: AppColors.blueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
          SizedBox(
            height: 85.h,
          ),
          Center(
              child: Text(
            "Enter Further Details",
            style: jost600(28.sp, AppColors.blueColor),
          )),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Column(
              children: [
                CustomTextField1(
                  hintText: "@handle",
                  prefixIcon: Icons.person,
                  borderColor: AppColors.border,
                  borderWidth: 1.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomDropdownMenu(
                  items: ['Option 1', 'Option 2', 'Option 3'],
                  hintText: 'Select your Interests',
                  borderWidth: 1.w,
                  borderColor: AppColors.border,
                  prefixImage: 'assets/images/interests.png',
                  onChanged: (value) {
                    print('Selected: $value');
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomDropdownMenu(
                  items: ['Option 1', 'Option 2', 'Option 3'],
                  hintText: 'Organization type',
                  borderWidth: 1.w,
                  borderColor: AppColors.border,
                  prefixImage: 'assets/images/organization.png',
                  onChanged: (value) {
                    print('Selected: $value');
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomDropdownMenu(
                  items: ['Option 1', 'Option 2', 'Option 3'],
                  hintText: 'Your role',
                  borderWidth: 1.w,
                  borderColor: AppColors.border,
                  prefixImage: 'assets/images/role.png',
                  onChanged: (value) {
                    print('Selected: $value');
                  },
                ),
                SizedBox(
                  height: 127.h,
                ),
                CustomButton(
                    text: "Complete", color: AppColors.blueColor, onPressed: () {
                      Get.to(AppNavBar());
                }),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
