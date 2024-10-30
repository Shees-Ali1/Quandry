import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/setting_screen/settings_screen.dart';
import 'dart:io';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:quandry/widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? _imagePath; // Store the image path

  // Controllers for the text fields
  final TextEditingController firstname = TextEditingController();


  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to free resources
    firstname.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppbarSmall(
          title: "Change Password", // Change title as needed
          iconImage: AppImages.back_icon, // Change icon as needed
          onIconTap: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70.h),
                Text("Enter Old Password", style: jost700(12.sp, AppColors.blueColor),),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  child: CustomTextField1(
                    hintText: '*********',
                    obscureText: true,
                    obscuringCharacter: '*',
                    suffixIcon: Icons.visibility,
                    hintTextSize: 14.65.sp, prefixIcon: null,
                  ),
                ),
                SizedBox(height: 23.h),
                Text("Enter New Password", style: jost700(12.sp, AppColors.blueColor),),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  child: CustomTextField1(
                    hintText: '*********',
                    obscureText: true,
                    obscuringCharacter: '*',
                    suffixIcon: Icons.visibility,
                    hintTextSize: 14.65.sp, prefixIcon: null,
                  ),
                ),
                SizedBox(height: 369.h),
                /// Save Button
                CustomButton(text: "Save", color: AppColors.blueColor, onPressed: (){
                  Get.to(SettingsScreen());
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
