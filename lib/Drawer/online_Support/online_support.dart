import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/controllers/chat_controller.dart';
import 'package:quandry/controllers/profile_controller.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TechnicalSupportChatScreen extends StatefulWidget {
  const TechnicalSupportChatScreen ({super.key});

  @override
  State<TechnicalSupportChatScreen> createState() => _TechnicalSupportChatScreenState();
}

class _TechnicalSupportChatScreenState extends State<TechnicalSupportChatScreen> {
  final ChatController chatVM = Get.put(ChatController());
  final ProfileController profileVM = Get.put(ProfileController());

  final TextEditingController message = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppbarSmall(
        title: "Online Support",

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
              child: StreamBuilder(
                stream: chatVM.getMessages(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: AppColors.blueColor,));
                  } else if (snapshot.hasError){
                    debugPrint("Error in fetching support messages: ${snapshot.error}");
                    return Center(child: Text("An Error occurred", style: jost500(16.sp, AppColors.blueColor),));
                  } else if(snapshot.data!.docs.length == 0 && snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("There are no messages.", style: jost500(16.sp, AppColors.blueColor),));
                  } else if(snapshot.connectionState == ConnectionState.none){
                    return  Center(child: Text("No Internet!", style: jost500(16.sp, AppColors.blueColor),));
                  } else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){

                    var messages = snapshot.data!.docs;

                    return Container(
                      height: 120.h,// Adjusted width for better match
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return messages[index]["user_uid"] != FirebaseAuth.instance.currentUser!.uid
                              ? _buildSupportMessage(messages[index]["message"])
                              : _buildUserMessage(messages[index]["message"]);
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }

                }
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
        // Container(
        //   height: 37.92.h,
        //   width: 37.92,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //   ),
        //
        //     child: Image.asset(AppImages.profile_image_small,fit: BoxFit.contain,),
        // ),
        CircleAvatar(
          radius: 18.46.r,
          backgroundColor: AppColors.blueColor,
          child: Icon(Icons.person, size: 20.w, color: AppColors.greenbutton,),
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
                    controller: message,
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
              InkWell(
                autofocus: false,
                onTap: (){
                  chatVM.sendMessage(message.text.trim(), DateTime.now(), message);
                },
                child: Container(
                  height: 38.4.h,
                  width: 38.4.w,
                  decoration: BoxDecoration(
                      color: AppColors.fillcolor, // Send button color
                      borderRadius: BorderRadius.circular(11.52.r)
                  ),
                  child: Center(
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
