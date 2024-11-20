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
  final TextEditingController newPasswordController = TextEditingController();

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
    newPasswordController.dispose();
    super.dispose();
  }

  void _loadUserProfile() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          _profilePictureUrl = userData['profilePicture'];
          phone.text = userData['mobileNumber'] ?? '';
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
                  _pickImage(ImageSource.gallery);
                },
                child:
                    Text('Gallery', style: jost400(14.sp, AppColors.blueColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                child:
                    Text('Camera', style: jost400(14.sp, AppColors.blueColor)),
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
        _imagePath = pickedFile.path;
      });

      File imageFile = File(_imagePath!);
      try {
        String fileName =
            _user!.uid + DateTime.now().millisecondsSinceEpoch.toString();
        TaskSnapshot uploadTask =
            await _storage.ref('profile_pictures/$fileName').putFile(imageFile);
        String downloadUrl = await uploadTask.ref.getDownloadURL();

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

  /// Show dialog to input old password and update details
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
                  AuthCredential credentials = EmailAuthProvider.credential(
                    email: _user!.email!,
                    password: passwordController.text,
                  );
                  await _user!.reauthenticateWithCredential(credentials);

                  // Update email
                  if (email.text.isNotEmpty && email.text != _user!.email) {
                    await _user!.updateEmail(email.text);
                    await _firestore
                        .collection('users')
                        .doc(_user!.uid)
                        .update({
                      'email': email.text,
                    });
                  }

                  // Update password
                  if (newPasswordController.text.isNotEmpty) {
                    await _user!.updatePassword(newPasswordController.text);
                  }

                  // Update mobile number
                  String numericPhone =
                      phone.text.replaceAll(RegExp(r'\D'), '');
                  if (numericPhone.isNotEmpty) {
                    await _firestore
                        .collection('users')
                        .doc(_user!.uid)
                        .update({'mobileNumber': numericPhone});
                  }

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                } catch (e) {
                  print('Failed to update profile: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Failed to update profile. Please try again.')));
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
        FocusScope.of(context).unfocus();
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
                                backgroundColor:
                                    Color.fromRGBO(18, 26, 26, 0.30),
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
                Text("Change Phone Number",
                    style: jost700(12.sp, AppColors.blueColor)),
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
                  onChanged: (value) {
                    phone.text = value.completeNumber;
                  },
                ),
                SizedBox(height: 12.h),
                Text("Change Email",
                    style: jost700(12.sp, AppColors.blueColor)),
                SizedBox(height: 10.h),
                /// Change Email TextField
                CustomTextField1(
                  controller: email, // Added controller
                  hintText: 'yousafayub65@gmail.com',
                  prefixIcon: null,
                  borderColor: AppColors.textfieldBorder,
                  borderWidth: 1.w,
                ),
                SizedBox(height: 15.h),
                Text("Change Password", style: jost700(12.sp, AppColors.blueColor)),
                SizedBox(height: 10.h),
                /// Change Password TextField
                CustomTextField1(
                  controller: newPasswordController, // Added controller
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
              text: "Save", // Changed 'title' to 'text' to match your button's constructor
              color: AppColors.blueColor, // Use your defined button color
              onPressed: () async {
                try {
                  // Show the dialog to enter the old password
                  _showOldPasswordDialog();
                } catch (e) {
                  print('Error showing password dialog: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update profile. Please try again.')),
                  );
                }
              },
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
