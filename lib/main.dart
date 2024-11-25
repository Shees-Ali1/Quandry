import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/controller/auth_controller.dart';
import 'package:quandry/controller/selectedtype_controller.dart';
import 'package:quandry/controllers/event_contorller.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/controllers/nav_bar_controller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/controllers/user_controller.dart';
import 'firebase_options.dart'; // Make sure you have this file generated
import 'package:quandry/onboarding/splash_Screen.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  Get.put(NavBarController());
  Get.put(Homecontroller());
  Get.put(SelectedTypeController());
  Get.put(UserController());
  // Get.put(EventController());
  // Get.put(ProfileController());

  await initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: AppColors.blueColor,
                onPrimary: AppColors.bluegrey,
                secondary: AppColors.greenbutton,
                onSecondary: AppColors.greenbutton,
                error: Colors.red,
                onError: Colors.red,
                surface: AppColors.whiteColor,
                onSurface:  AppColors.blueColor
            )
          ),
          debugShowCheckedModeBanner: false,
          title: 'QWANDERY',
          home: SplashScreen(),
        );
      },
    );
  }
}
