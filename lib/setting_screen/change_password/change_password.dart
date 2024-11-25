import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quandry/controller/auth_controller.dart';
import 'package:quandry/setting_screen/settings_screen.dart';
import 'dart:io';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'package:quandry/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthController authVM = Get.find<AuthController>();
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;




  @override
  void initState() {
    super.initState();
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      authVM.loading.value = true;

      try {
        // Get the current user
        User? user = _auth.currentUser;

        if (user != null) {
          // Re-authenticate with old password
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: oldPass.text,
          );

          await user.reauthenticateWithCredential(credential);

          // Update to new password
          await user.updatePassword(newPass.text);

          Get.snackbar("Success", "Password changed", colorText: Colors.white, backgroundColor: AppColors.blueColor);


          // Clear fields after success
          oldPass.clear();
          newPass.clear();
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred.";
        if (e.code == 'wrong-password') {
          errorMessage = "The old password is incorrect.";
        } else if (e.code == 'weak-password') {
          errorMessage = "The new password is too weak.";
        } else if (e.code == 'requires-recent-login') {
          errorMessage =
          "Please re-login and try changing the password again.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        authVM.loading.value = false;
      }
    }
  }


  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to free resources
    oldPass.dispose();
    newPass.dispose();
    super.dispose(); // Call the superclass dispose method
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppbarSmall(
          title: "Change Password", // Change title as needed
        
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70.h),
                  Text("Enter Old Password", style: jost700(12.sp, AppColors.blueColor),),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    child: CustomTextField1(
                      controller: oldPass,
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
                      controller: newPass,
                      hintText: '*********',
                      obscureText: true,
                      obscuringCharacter: '*',
                      suffixIcon: Icons.visibility,
                      hintTextSize: 14.65.sp, prefixIcon: null,
                    ),
                  ),
                  SizedBox(height: 369.h),
                  /// Save Button
                  Obx(
                      ()=> CustomButton(
                        loading: authVM.loading.value,
                        text: "Save",
                        color: AppColors.blueColor,
                        onPressed: (){
                          if(authVM.loading.value == false){
                            _changePassword();
                          }
                        }
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
