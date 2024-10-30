import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/Homepage/homepage.dart';
import 'package:quandry/auth/login.dart';
import 'package:quandry/auth/signup.dart';
import 'package:quandry/bottom_nav/bottom_nav.dart';
import 'package:quandry/onboarding/main_onbaording.dart';

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
          home: MainOnBoardingView(),
        );
      },
    );
  }
}
