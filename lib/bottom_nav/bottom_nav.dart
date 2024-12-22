import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/Drawer/drawer.dart';
import 'package:quandry/Homepage/homepage.dart';
import 'package:quandry/attending_screen/attending_screen_main.dart';
import 'package:quandry/calendar_screen/calendar_screen_main.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/controllers/home_controller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/controllers/user_controller.dart';
import 'package:quandry/profile_screen/profile_screen_main.dart';
import 'package:quandry/profile_screen/user_profile.dart';
import 'package:quandry/setting_screen/settings_screen.dart';


import '../../const/images.dart';
import '../../controllers/nav_bar_controller.dart';
class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => AppNavBarState();
}

class AppNavBarState extends State<AppNavBar> {
  final ProfileController profileVM = Get.put(ProfileController());
  final Homecontroller homeVM = Get.find<Homecontroller>();
  final UserController userVM = Get.put(UserController());
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  @override
  void initState () {
    super.initState();

    profileVM.getBlockDelete();
    profileVM.getUserData();
    profileVM.getCurrentLocation();
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final NavBarController navBarController = Get.put(NavBarController());

  void navigateToPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
    _controller.jumpTo(pageIndex); // Update selected item in bottom bar
  }
  @override
  Widget build(BuildContext context) {
    bool isIpad = MediaQuery.of(context).size.width > 600;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconHeight = screenHeight * 0.05;
    double iconScale = iconHeight / 20;

    List<Widget> bottomBarPages = [
      HomeScreen(),
      // const AttendingScreenMain(),
      const CalendarScreenMain(),
       UserProfilePage(navbar: true,),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: navBarController.scaffoldKey,
      drawer: const MyDrawer(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
              (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        showBlurBottomBar: false,
        showShadow: false,
        itemLabelStyle: TextStyle(
          color: AppColors.backgroundColor,
          fontWeight: FontWeight.w400,
          fontSize: isIpad ? 5.sp : 8.sp,
        ),
        blurFilterY: 10,
        blurFilterX: 10,
        notchBottomBarController: _controller,
        notchColor: AppColors.blueColor,
        color: AppColors.blueColor,
        showLabel: true,
        shadowElevation: 0,
        kBottomRadius: 15.0,
        bottomBarWidth: 100.w,
        bottomBarHeight: 11.h,
        removeMargins: false,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Image.asset(AppImages.home_icon),
            activeItem: Image.asset(AppImages.home_icon, fit: BoxFit.contain),
            itemLabel: 'Home'.tr,
          ),
          // BottomBarItem(
          //   inActiveItem: Image.asset(AppImages.attending_icon,width: 40,height: 40,fit: BoxFit.fill,color: Colors.white,),
          //   activeItem: Image.asset(AppImages.attending_icon, width: 40,height: 40,fit: BoxFit.fill
          //     ,color: Colors.white,),
          //   itemLabel: 'My Path'.tr,
          // ),
          BottomBarItem(
            inActiveItem: Image.asset(AppImages.attending_icon,color: Colors.white,),
            activeItem: Image.asset(AppImages.attending_icon, fit: BoxFit.contain,color: Colors.white,),
            itemLabel: 'My Path'.tr,
          ),
          BottomBarItem(
            inActiveItem: Image.asset(AppImages.profile_icon),
            activeItem: Image.asset(AppImages.profile_icon, fit: BoxFit.contain),
            itemLabel: 'Profile'.tr,
          ),
        ],
        onTap: (index) {
          navigateToPage(index); // Use the public `navigateToPage` method
        },
        kIconSize: 19.sp,
      ),
    );
  }
}
// class AppNavBar extends StatefulWidget {
//   const AppNavBar({super.key});
//
//   @override
//   State<AppNavBar> createState() => _AppNavBarState();
// }
//
// class _AppNavBarState extends State<AppNavBar> {
//   final UserController userVM = Get.put(UserController());
//
//   final _pageController = PageController(initialPage: 0);
//
//   final _controller = NotchBottomBarController(index: 0);
//
//   int maxCount = 4;
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   final NavBarController navBarController = Get.put(NavBarController());
//
//   void _navigateToPage(int pageIndex) {
//     _pageController.jumpToPage(pageIndex);
//     _controller.jumpTo(pageIndex);
//     Navigator.pop(context); // Close the drawer after navigation
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isIpad = MediaQuery.of(context).size.width > 600;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     // Calculate the dynamic icon height (e.g., 5% of the screen height)
//     double iconHeight = screenHeight * 0.05; // Adjust the percentage as needed
//
//     // Determine the scale factor for the icons
//     double iconScale = iconHeight / 20;
//
//     // Move bottomBarPages into build method to ensure userVM is accessible
//     List<Widget> bottomBarPages = [
//        HomeScreen(),
//       const AttendingScreenMain(),
//       const CalendarScreenMain(),
//       const SettingsScreen(),
//     ];
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       key: navBarController.scaffoldKey,
//       drawer: const MyDrawer(),
//
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: List.generate(
//           bottomBarPages.length,
//               (index) => bottomBarPages[index],
//         ),
//       ),
//       extendBody: true,
//
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         showBlurBottomBar: false,
//         showShadow: false,
//         itemLabelStyle: TextStyle(
//           color: AppColors.backgroundColor,
//           fontWeight: FontWeight.w400,
//           fontSize: isIpad ? 5.sp : 8.sp,
//         ),
//         blurFilterY: 10,
//         blurFilterX: 10,
//         notchBottomBarController: _controller,
//         notchColor: AppColors.blueColor,
//         color: AppColors.blueColor,
//         showLabel: true,
//         shadowElevation: 0,
//         kBottomRadius: 15.0,
//         bottomBarWidth: 100.w,
//         bottomBarHeight: 11.h,
//         removeMargins: false,
//         durationInMilliSeconds: 300,
//         bottomBarItems: [
//           BottomBarItem(
//             inActiveItem: Image.asset(AppImages.home_icon),
//             activeItem: Image.asset(
//               AppImages.home_icon,
//               fit: BoxFit.contain,
//               alignment: Alignment.center,
//             ),
//             itemLabel: 'Home'.tr,
//           ),
//           BottomBarItem(
//             inActiveItem: Image.asset(AppImages.attending_icon),
//             activeItem: Image.asset(
//               fit: BoxFit.contain,
//               alignment: Alignment.center,
//
//               AppImages.attending_icon,
//             ),
//             itemLabel: 'Attending'.tr,
//           ),
//           BottomBarItem(
//             inActiveItem: Image.asset(AppImages.calender_icon),
//             activeItem: Image.asset(
//               alignment: Alignment.center,
//               fit: BoxFit.contain,
//
//               AppImages.calender_icon,
//             ),
//             itemLabel: 'Calendar'.tr,
//           ),
//           BottomBarItem(
//             inActiveItem: Image.asset(AppImages.profile_icon),
//             activeItem: Image.asset(
//               alignment: Alignment.center,
//               fit: BoxFit.contain,
//
//               AppImages.profile_icon,
//             ),
//             itemLabel: 'Profile'.tr,
//           ),
//         ],
//         onTap: (index) {
//           _pageController.jumpToPage(index);
//         },
//         kIconSize: 19.sp,
//       ),
//     );
//   }
// }
