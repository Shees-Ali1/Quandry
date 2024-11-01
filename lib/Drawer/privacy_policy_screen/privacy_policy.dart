import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/widgets/appbar_small.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarSmall(
          iconImage: AppImages.back_icon, // Set your custom back icon
          onIconTap: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.blueColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7.h),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 105.w,
                    height: 112.h,
                    child: Image.asset(
                        AppImages.quanderyLogo),
                  ),
                ),
                SizedBox(height: 15.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w600

                    ) ,
                    // textColor: buttonColor,
                    // fontWeight: FontWeight.w600,
                    // fontsize: 22.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  // height: 538.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.appBarColor,
                    borderRadius: BorderRadius.circular(5.69.r),
                    border: Border.all(
                      color: AppColors.fillcolor,
                      width: 1.0.w,
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(

                      "Lorem ipsum dolor sit amet Consectetur adipiscing elit. Natoque phasellus lobortis mattis cursus faucibus hac proin risus. Turpis phasellus massa ullamcorper volutpat.\n Ornare commodo non integer fermentum nisi, morbi id. \n\nVel tortor mauris feugiat amet, maecenas facilisis risus, in faucibus. Vestibulum ullamcorper fames eget enim diam fames faucibus duis ac. Aliquam non tellus semper in dignissim nascetur venenatis lacus. Lectus vel non varius interdum vel tellus sed mattis. Sit laoreet auctor arcu mauris tincidunt sociis tristique pharetra neque. Aliquam pharetra elementum nisl sapien. Erat nisl morbi eu dolor in. Sapien ut lacus dui libero morbi tristique. Sit praesent mi, dolor, magna in pellentesque sollicitudin odio sed. \n\nSit nibh aliquam enim ipsum lectus sem fermentum congue velit. Purus habitant odio in morbi aliquet velit pulvinar. Facilisis ut amet interdum pretium. Fames pretium eget orci facilisis mattis est libero facilisis ullamcorper. Est auctor amet egestas risus libero et. Auctor faucibus sit id fringilla vitae. Ac volutpat sodales tristique ut netus turpis. Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet Consectetur adipiscing elit. Natoque phasellus lobortis mattis cursus faucibus hac proin risus. Turpis phasellus massa ullamcorper volutpat.\n Ornare commodo non integer fermentum nisi, morbi id. \n\nVel tortor mauris feugiat amet, maecenas facilisis risus, in faucibus. Vestibulum ullamcorper fames eget enim diam fames faucibus duis ac. Aliquam non tellus semper in dignissim nascetur venenatis lacus. Lectus vel non varius interdum vel tellus sed mattis. Sit laoreet auctor arcu mauris tincidunt sociis tristique pharetra neque. Aliquam pharetra elementum nisl sapien. Erat nisl morbi eu dolor in. Sapien ut lacus dui libero morbi tristique. Sit praesent mi, dolor, magna in pellentesque sollicitudin odio sed. \n\nSit nibh aliquam enim ipsum lectus sem fermentum congue velit. Purus habitant odio in morbi aliquet velit pulvinar. Facilisis ut amet interdum pretium. Fames pretium eget orci facilisis mattis est libero facilisis ullamcorper. Est auctor amet egestas risus libero et. Auctor faucibus sit id fringilla vitae. Ac volutpat sodales tristique ut netus turpis. Lorem ipsum dolor sit amet, consectetur",
                      // textColor: Color.fromRGBO(255, 255, 255, 1),
                      // fontWeight: FontWeight.w300,
                      // fontsize: 11.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}