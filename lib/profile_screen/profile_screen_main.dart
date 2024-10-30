import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';

import 'dart:io';

import 'package:quandry/widgets/appbar_small.dart';

class ProfileScreenMain extends StatefulWidget {
  const ProfileScreenMain({super.key});

  @override
  _ProfileScreenMainState createState() => _ProfileScreenMainState();
}

class _ProfileScreenMainState extends State<ProfileScreenMain> {
  String? _imagePath; // Store the image path

  // Controllers for the text fields
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to free resources
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    super.dispose();
  }

  /// Image Source dialog Box
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Choose an Option",
            style: jost400(
              16,
              AppColors.blueColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery); // Pick image from gallery
                },
                child:
                    Text('Gallery', style: jost400(14.sp, AppColors.blueColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera); // Take photo with camera
                },
                child: Text('Camera', style: jost400(14.sp, AppColors.blueColor)),
              ),
            ],
          ),
          backgroundColor: AppColors.backgroundColor,
        );
      },
    );
  }

  /// Function to pick an image
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: source); // Use pickImage instead of getImage

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Update the image path
      });
    }
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
//         // title: "My Custom Title", // Change title as needed
          iconImage: AppImages.drawer_icon, // Change icon as needed
          onIconTap: () {
// Define the action when the icon is tapped
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              children: [
                SizedBox(height: 44.h),

                /// Profile Image And Camera Icon
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 138.w,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120.h,
                          width: 120.w,
                          child: CircleAvatar(
                            backgroundImage: _imagePath != null
                                ? FileImage(File(_imagePath!))
                                : AssetImage(AppImages.profile_pic)
                                    as ImageProvider,
                            // Use the image from AppImages
                            radius: 60, // Optional: customize radius if needed
                          ),
                        ),

                        /// Image Picker
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _showImageSourceDialog(context),
                            // Open image source dialog
                            child: SizedBox(
                              width: 46.w,
                              height: 46.h,
                              child: CircleAvatar(
                                backgroundColor: AppColors.blueColor,
                                child: SizedBox(
                                  width: 23.w,
                                  height: 20.7.h,
                                  child: Image.asset(AppImages
                                      .camera_icon), // Use Image.asset to load the image
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 56.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
