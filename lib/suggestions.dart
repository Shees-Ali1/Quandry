import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:quandry/widgets/custom_button.dart';
import 'const/textstyle.dart';

class SuggestEventForm extends StatefulWidget {
  final String uid; // Accept UID from the previous screen

  SuggestEventForm({required this.uid});

  @override
  State<SuggestEventForm> createState() => _SuggestEventFormState();
}

class _SuggestEventFormState extends State<SuggestEventForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController correctionsController = TextEditingController();
  final TextEditingController sugguestNewController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController suggestionControoler = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _correctionsFocusNode = FocusNode();
  final FocusNode _sugguestNewFocusNode = FocusNode();
  final FocusNode _complaintFocusNode = FocusNode();
  final FocusNode _suggestionFocusNode = FocusNode();

  final Color accentColor = const Color.fromRGBO(255, 255, 255, 1);
  final Color textFieldColor = const Color.fromRGBO(216, 229, 236, 1);

  // Function to store the suggestion in Firestore
  Future<void> _storeSuggestion() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firestore instance
        final firestore = FirebaseFirestore.instance;

        // Suggestion data
        final suggestionData = {
          'eventName': _nameController.text.trim(),
          'corrections': correctionsController.text.trim(),
          'suggestNew': sugguestNewController.text.trim(),
          'complaints': complaintController.text.trim(),
          'suggestions': suggestionControoler.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        };

        // Add suggestion as a sub-collection in the event document
        await firestore
            .collection('events')
            .doc(widget.uid) // Match the event document by UID
            .collection('suggestions') // Sub-collection
            .add(suggestionData);

        // Show success message
        Get.snackbar(
          'Success',
          'Your suggestion has been submitted!',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );

        // Clear the form fields
        _nameController.clear();
        correctionsController.clear();
        sugguestNewController.clear();
        complaintController.clear();
        suggestionControoler.clear();
      } catch (error) {
        // Show error message
        Get.snackbar(
          'Error',
          'Failed to submit your suggestion. Please try again.',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          automaticallyImplyLeading: false,
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
                SizedBox(width: 20.w),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5.w),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Image.asset(
                        AppImages.back_icon,
                        height: 12.h,
                        width: 13.w,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                      'Event Suggestions',
                      style: jost700(16.sp, Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(width: 20.w),
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
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: correctionsController,
                focusNode: _correctionsFocusNode,
                labelText: 'Corrections for Existing Events',
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: sugguestNewController,
                focusNode: _sugguestNewFocusNode,
                labelText: 'Suggest a New Event',
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: complaintController,
                focusNode: _complaintFocusNode,
                labelText: 'Complaints',
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: suggestionControoler,
                focusNode: _suggestionFocusNode,
                labelText: 'Suggestions',
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Save",
                color: AppColors.blueColor,
                onPressed: _storeSuggestion,
              ),
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
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: accentColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
      style: TextStyle(color: AppColors.blueColor),
      validator: (value) => value!.isEmpty ? 'Please enter a value' : null,
    );
  }
}
