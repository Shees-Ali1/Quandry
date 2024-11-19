import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'dart:io';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:quandry/widgets/custom_textfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreenMain extends StatefulWidget {
  const ProfileScreenMain({super.key});

  @override
  _ProfileScreenMainState createState() => _ProfileScreenMainState();
}

class _ProfileScreenMainState extends State<ProfileScreenMain> {
  String? _imagePath; // Store the image path
  String? _profilePictureUrl;

  // Controllers for the text fields
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _loadUserProfile();
    }
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    phone.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loadUserProfile() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          _profilePictureUrl = userData['profilePicture'];

          // Check if the mobileNumber field exists before using it
          phone.text = userData.containsKey('mobileNumber')
              ? userData['mobileNumber']
              : ''; // Default to empty string if the field is missing

          email.text = _user!.email ?? '';
        });
      }
    } catch (e) {
      print('Failed to load user profile: $e');
    }
  }



  /// Image Source dialog Box
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Choose an Option",
            style: jost400(16, AppColors.blueColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery); // Pick image from gallery
                },
                child: Text('Gallery', style: jost400(14.sp, AppColors.blueColor)),
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
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Update the image path
      });

      // Upload image to Firebase Storage and get the download URL
      File imageFile = File(_imagePath!);
      try {
        String fileName = _user!.uid + DateTime.now().millisecondsSinceEpoch.toString();
        TaskSnapshot uploadTask = await _storage.ref('profile_pictures/$fileName').putFile(imageFile);
        String downloadUrl = await uploadTask.ref.getDownloadURL();

        // Update the profile picture URL in Firestore
        await _firestore.collection('users').doc(_user!.uid).update({
          'profilePicture': downloadUrl,
        });

        setState(() {
          _profilePictureUrl = downloadUrl;
        });
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  /// Update mobile number
  void _updateMobileNumber() async {
    try {
      await _firestore.collection('users').doc(_user!.uid).update({
        'mobileNumber': phone.text,
      });
      print('Mobile number updated');
    } catch (e) {
      print('Failed to update mobile number: $e');
    }
  }

  /// Show dialog to input old password
  void _showOldPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Old Password"),
          content: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Enter old password'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Verify old password
                  AuthCredential credentials = EmailAuthProvider.credential(
                    email: _user!.email!,
                    password: passwordController.text,
                  );

                  await _user!.reauthenticateWithCredential(credentials);

                  // After successful re-authentication, update the profile
                  await _user!.updateEmail(email.text);
                  await _user!.updatePassword(passwordController.text);

                  // Update mobile number
                  _updateMobileNumber();

                  // Save profile image URL if changed
                  if (_imagePath != null) {
                    await _firestore.collection('users').doc(_user!.uid).update({
                      'profilePicture': _profilePictureUrl,
                    });
                  }

                  // Update Firestore with new data
                  await _firestore.collection('users').doc(_user!.uid).update({
                    'email': email.text,
                    'mobileNumber': phone.text,
                  });

                  // Close the dialog and show success message
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                } catch (e) {
                  print('Failed to verify password: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to update profile. Please try again.')));
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppbarSmall(
          title: "Settings",
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundImage: _profilePictureUrl != null
                                ? NetworkImage(_profilePictureUrl!)
                                : AssetImage(AppImages.profile_pic)
                            as ImageProvider,
                            radius: 60,
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _showImageSourceDialog(context),
                            child: SizedBox(
                              width: 46.w,
                              height: 46.h,
                              child: CircleAvatar(
                                backgroundColor: Color.fromRGBO(18, 26, 26, 0.30),
                                child: SizedBox(
                                  width: 23.w,
                                  height: 20.7.h,
                                  child: Image.asset(AppImages.camera_icon),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 43.h),
                Text("Change Phone Number", style: jost700(12.sp, AppColors.blueColor)),
                SizedBox(height: 10.26.h),
                IntlPhoneField(
                  flagsButtonPadding: EdgeInsets.only(left: 13.w),
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  showDropdownIcon: false,
                  decoration: InputDecoration(
                    hintText: '0000000000',
                    filled: true,
                    fillColor: AppColors.fillcolor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    counterText: '',
                    hintStyle: TextStyle(
                      color: AppColors.calendartext,
                      fontFamily: 'jost',
                      fontSize: 14.65.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.31.r),
                      borderSide: BorderSide(color: AppColors.textfieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.31.r),
                      borderSide: BorderSide(color: AppColors.textfieldBorder),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.31.r),
                      borderSide: BorderSide(color: AppColors.textfieldBorder),
                    ),
                  ),
                  initialCountryCode: 'AE',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                SizedBox(height: 17.94.h),
                Text("Change Email", style: jost700(12.sp, AppColors.blueColor)),
                SizedBox(height: 10.h),
                CustomTextField1(
                  hintText: 'yousafayub65@gmail.com',
                  prefixIcon: null,
                  borderColor: AppColors.textfieldBorder,
                  borderWidth: 1.w,
                ),
                SizedBox(height: 15.h),
                Text("Change Password", style: jost700(12.sp, AppColors.blueColor)),
                SizedBox(height: 10.h),
                CustomTextField1(
                  borderColor: AppColors.textfieldBorder,
                  borderWidth: 1.w,
                  hintText: 'Enter your new password',
                  obscureText: true,
                  obscuringCharacter: '*',
                  suffixIcon: Icons.visibility,
                  hintTextSize: 12.sp,
                  prefixIcon: null,
                ),
                SizedBox(height: 31.h),
                CustomButton(
                  text: "Save",
                  color: AppColors.blueColor,
                  onPressed: _showOldPasswordDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
