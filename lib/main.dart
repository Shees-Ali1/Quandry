import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/auth/further_details.dart';

import 'package:quandry/auth/login.dart';
import 'package:quandry/auth/signup.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/onboarding/main_onbaording.dart';
import 'package:quandry/onboarding/splash_Screen.dart';

import 'auth/forgotPassword/forgot_password.dart';
import 'auth/forgotPassword/forgot_phone_auth.dart';
import 'auth/forgotPassword/forgot_phone_number.dart';
import 'auth/forgotPassword/forgot_reset.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QWANDERY',
          home: SplashScreen(),
        );
      },
    );
  }
}


// child: CustomPhoneNumberField(
//   childWidget:  CountryCodePicker(
//     hideSearch: false,
//     enabled: true,
//     showDropDownButton: false,
//     onChanged: print,
//     // countryFilter: ['IQ'],
//     // initialSelection: 'IQ',
//     // favorite: ['+964', ''],
//     showCountryOnly: false,
//     showOnlyCountryWhenClosed: false,
//     alignLeft: false,
//   ),
//   controller: phoneController,
//   hintText: "",
//   passwordFunction: () {
//     phoneController.clear();
//     return null;
//   },
//   keyboardType: TextInputType.number,
//   hintColor: AppColors.greyColor,
//   hintTextSize: 15.sp,
//   isBorder: true,
//   borderRadius: 13.sp,
//   fillColor: AppColors.transparentColor,
//   suffixIcon: Icons.cancel,
// ),