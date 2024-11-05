import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'const/textstyle.dart';

class SuggestEventForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();


  final Color accentColor = Color.fromRGBO(255, 255, 255, 1);
  final Color textFieldColor = Color.fromRGBO(216, 229, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(60.h), // Set the height of the custom app bar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back arrow
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
            ),
            child: Row(

              children: [
                SizedBox(width: 20.w,),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: GestureDetector(
                    onTap: (){
                     Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5.w), // White border with desired width
                        borderRadius: BorderRadius.circular(20.r), // Optional: rounded corners for the border
                      ),
                      child: Image.asset(
                        AppImages.back_icon,
                        height: 12.h,
                        width: 13.w,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 60.w,),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      'Event Suggestions',
                      style: jost700(16.sp, Colors.white), // Custom font style
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                labelText: 'Event Name',
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _dateController,
                focusNode: _dateFocusNode,
                labelText: 'Corrections for Existing Events',
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _dateController,
                focusNode: _dateFocusNode,
                labelText: 'Suggest a New Event',
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _locationController,
                focusNode: _locationFocusNode,
                labelText: 'Complaints',
              ),
              SizedBox(height: 16),
              _buildTextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                labelText: 'Suggestions',
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                  text: "Save", color: AppColors.blueColor, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: focusNode.hasFocus ? null : labelText,
        filled: true,
        fillColor: textFieldColor,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12.r), // Adjust the radius as needed
          borderSide: BorderSide(color: AppColors.border,),
          // Default border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // Consistent radius
          borderSide:
              BorderSide(color: accentColor), // Border color when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // Consistent radius
          borderSide:
              BorderSide(color: AppColors.border), // Border color when enabled
        ),
      ),
      style: TextStyle(color: AppColors.blueColor),
      validator: (value) => value!.isEmpty ? 'Please enter a value' : null,
      onTap: () {
        // Clear the placeholder text when the field is tapped
        if (controller.text == labelText) {
          controller.clear();
        }
      },
    );
  }
}
