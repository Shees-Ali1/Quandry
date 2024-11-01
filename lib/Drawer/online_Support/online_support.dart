import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/widgets/appbar_small.dart';

class TechnicalSupportChatScreen extends StatelessWidget {
  const TechnicalSupportChatScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppbarSmall(
        title: "Technical Support Team",
        iconImage: AppImages.back_icon, // Set your custom back icon
        onIconTap: () {
          Get.back();
        },
      ),
      body:
      /// Chat Field
      GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside

        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  // Support Message
                  _buildSupportMessage(
                    'Alright.\n\nYou can track your progress by accessing the "My Courses" or "My Progress" section in the app.\n\nIt will show you the courses you’re enrolled in, your completion status, and any assessments or quizzes you’ve completed.',
                  ),
                  // User Message
                  _buildUserMessage("That's good to know."),
                  // User Message
                  _buildUserMessage(
                      "Thank you so much for your help! I appreciate it."),
                  // Support Message
                  _buildSupportMessage(
                    "You’re very welcome!\n\nIf you have any more questions in the future or need assistance with anything else, feel free to reach out.",
                  ),
                  _buildSupportMessage('Happy studying!'),
                  _buildSupportMessage("You’re very welcome!\n\nIf you have any more questions in the future or need assistance with anything else, feel free to reach out.",
                  ),
                ],
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }
  /// Support Team Text Field Design
  Widget _buildSupportMessage(String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Profile Image
        Container(
          height: 37.92.h,
          width: 37.92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),

            child: Image.asset(AppImages.profile_image_small,fit: BoxFit.contain,),
        ),
        SizedBox(width: 10.w),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 28, 49, 1), // Support bubble color
              borderRadius: BorderRadius.circular(5.69.r),
            ),
            child: Text(
              message,
              style:  jost500(12.sp, AppColors.appbar_text),
            ),
          ),
        ),
      ],
    );
  }
  /// User Text Message Field Design
  Widget _buildUserMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 220.w, // Limit the message bubble width to 220
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.fillcolor, // User bubble color
              borderRadius: BorderRadius.circular(5.69.r),
            ),
            child: Text(
              message,
              style: jost500(12.sp, AppColors.calendartext),
            ),
          ),
        ),
      ],
    );
  }
  /// Type Message TextField
  Widget _buildMessageInput() {
    return Container(
      height: 79.8.h,
      width: double.infinity.w,
      color: Color(0xff001A2E),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.4.w),
        child: SizedBox(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 56.63.h, // Height for the container
                  width: double.infinity, // Set to your desired width
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      hintStyle: TextStyle(color: AppColors.calendartext),
                      filled: true,
                      fillColor: AppColors.fillcolor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h), // Adjust vertical padding
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true, // Set isDense to true
                    ),
                    style: TextStyle(color: AppColors.calendartext),
                  ),
                ),
              ),
              SizedBox(width: 11.52.w),
              Container(
                height: 38.4.h,
                width: 38.4.w,
                decoration: BoxDecoration(
                    color: AppColors.fillcolor, // Send button color
                    borderRadius: BorderRadius.circular(11.52.r)
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: (){},
                    child: SizedBox(
                      height: 23.04.h,
                      width: 23.04.w,
                      child: Image.asset(AppImages.send_image_icon,
                        color: AppColors.blueColor,
                        fit: BoxFit.contain,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
