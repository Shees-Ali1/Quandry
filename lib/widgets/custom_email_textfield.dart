// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/images.dart';

import '../const/colors.dart';

class CustomTextFiled extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  bool? isFilled;
  Color? fillColor;
  String? fontFamily;
  Color? hintColor;
  FontWeight? fontWeight;
  double? hintTextSize;
  String? Function(String?)? validator;
  Function(String)? onChange;
  VoidCallback? passwordFunction;
  double? borderRadius;
  bool? isBorder;
  IconData? suffixIcon;
  String? prefixIcon;
  bool? isErrorBorder;
  TextInputType? keyboardType;
  bool? isPassword;
  IconData? beforePasswordIcon;
  IconData? afterPasswordIcon;
  bool? isObscure;
  final bool readOnly;

  CustomTextFiled({
    super.key,
    this.hintText,
    this.controller,
    this.isFilled,
    this.fillColor,
    this.fontFamily,
    this.hintColor,
    this.hintTextSize,
    this.fontWeight,
    this.validator,
    this.isBorder,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.isErrorBorder,
    this.onChange,
    this.keyboardType,
    this.isPassword,
    this.passwordFunction,
    this.beforePasswordIcon,
    this.isObscure,
    this.afterPasswordIcon,
    required this.readOnly,
  });

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: isObscure ?? true,
      focusNode: _focusNode,
      style: TextStyle(
        color: AppColors.blueColor,
        fontSize: 14.65.sp,
        fontWeight: FontWeight.w400,
      ),
      readOnly: readOnly,
      textAlign: TextAlign.start,  // Center the written value horizontally
      textAlignVertical: TextAlignVertical.center,  // Center the written value vertically
      decoration: InputDecoration(
        suffixIcon: isPassword == true
            ? IconButton(
          onPressed: passwordFunction,
          icon: Icon(
            isObscure == true ? beforePasswordIcon : afterPasswordIcon,
            color: AppColors.blueColor,
          ),
        )
            : Icon(suffixIcon),
        prefixIcon: prefixIcon != null
            ? Image.asset(
          prefixIcon!,
          color: AppColors.blueColor,
          scale: 2.8,
        )
            : null,
        filled: isFilled ?? true,
        fillColor: fillColor ?? AppColors.backgroundColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: fontFamily ?? 'jost',
          fontSize: hintTextSize ?? 14.65.sp,
          color: hintColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),

        border: isBorder == true
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.31.r),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        )
            : InputBorder.none,
        errorBorder: isErrorBorder == true
            ? OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(13.31.r),
        )
            : InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(13.31.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(13.31.r),
        ),
      ),
    );
  }
}


class EmailCustomTextFiled extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  bool? isFilled;
  Color? fillColor;
  String? fontFamily;
  Color? hintColor;
  FontWeight? fontWeight;
  double? hintTextSize;
  String? Function(String?)? validator;
  Function(String)? onChange;
  VoidCallback? passwordFunction;
  double? borderRadius;
  bool? isBorder;
  IconData? suffixIcon;
  String? prefixIcon;
  bool? isErrorBorder;
  TextInputType? keyboardType;
  bool? isPassword;
  IconData? beforePasswordIcon;
  IconData? afterPasswordIcon;
  bool? isObscure;
  final bool readOnly;
  final String? obscuringCharacter;

  EmailCustomTextFiled({
    super.key,
    this.hintText,
    this.controller,
    this.isFilled,
    this.fillColor,
    this.fontFamily,
    this.hintColor,
    this.hintTextSize,
    this.fontWeight,
    this.validator,
    this.isBorder,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.isErrorBorder,
    this.onChange,
    this.keyboardType,
    this.isPassword,
    this.passwordFunction,
    this.beforePasswordIcon,
    this.isObscure,
    this.afterPasswordIcon,
    required this.readOnly,
    this.obscuringCharacter,
  });

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      focusNode: _focusNode,
      style: TextStyle(
        color: AppColors.blueColor,
        fontSize: 14.65.sp,
        fontWeight: FontWeight.w400,
      ),
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon: isPassword == true
            ? IconButton(
          onPressed: passwordFunction,
          icon: Icon(
            // size: 15,
            isObscure == true ? beforePasswordIcon : afterPasswordIcon,
            color: AppColors.blueColor,
          ),
        )
            : Icon(
          suffixIcon,

        ),
        prefixIcon: prefixIcon != null
            ? Image.asset(
          prefixIcon!,
          color: AppColors.blueColor,
          scale: 3,
          // fit: BoxFit.fill,
        )
            : null,
        filled: isFilled ?? true,
        fillColor: fillColor ?? AppColors.backgroundColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: fontFamily ?? 'jost',
          fontSize: hintTextSize ?? 15.sp,
          color: hintColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
        border: isBorder == true
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.31.r),
          borderSide:  BorderSide(color: AppColors.border, width: 3.w),
        )
            : InputBorder.none,
        errorBorder: isErrorBorder == true
            ? OutlineInputBorder(
          borderSide:  BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(13.31.r),
        )
            : InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppColors.border, width: 3.w
          ),
          borderRadius: BorderRadius.circular(13.31.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppColors.border, width: 3.w),
          borderRadius: BorderRadius.circular(13.31.r),
        ),
      ),
    );
  }
}

class SignCustomTextFiled extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  bool? isFilled;
  Color? fillColor;
  String? fontFamily;
  Color? hintColor;
  FontWeight? fontWeight;
  double? hintTextSize;
  String? Function(String?)? validator;
  Function(String)? onChange;
  VoidCallback? passwordFunction;
  double? borderRadius;
  bool? isBorder;
  IconData? suffixIcon;
  String? prefixIcon;
  bool? isErrorBorder;
  TextInputType? keyboardType;
  bool? isPassword;
  IconData? beforePasswordIcon;
  IconData? afterPasswordIcon;
  bool? isObscure;
  final bool readOnly;

  SignCustomTextFiled({
    super.key,
    this.hintText,
    this.controller,
    this.isFilled,
    this.fillColor,
    this.fontFamily,
    this.hintColor,
    this.hintTextSize,
    this.fontWeight,
    this.validator,
    this.isBorder,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.isErrorBorder,
    this.onChange,
    this.keyboardType,
    this.isPassword,
    this.passwordFunction,
    this.beforePasswordIcon,
    this.isObscure,
    this.afterPasswordIcon,
    required this.readOnly,
  });

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      focusNode: _focusNode,
      style: TextStyle(
        color: AppColors.blueColor,
        fontSize: 14.65.sp,
        fontWeight: FontWeight.w400,
      ),
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon: isPassword == true
            ? IconButton(
          onPressed: passwordFunction,
          icon: Icon(
            // size: 15,
            isObscure == true ? beforePasswordIcon : afterPasswordIcon,
            color: AppColors.blueColor,
          ),
        )
            : Icon(
          suffixIcon,

        ),
        prefixIcon: prefixIcon != null
            ? Image.asset(
          prefixIcon!,
          color: AppColors.blueColor,
          scale: 3,
          // fit: BoxFit.fill,
        )
            : null,
        filled: isFilled ?? true,
        fillColor: fillColor ?? Color(0xffB4C4D1),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: fontFamily ?? 'jost',
          fontSize: hintTextSize ?? 14.65.sp,
          color: hintColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
        border: isBorder == true
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),

        )
            : InputBorder.none,
        errorBorder: isErrorBorder == true
            ? OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1),

          borderRadius: BorderRadius.circular(13.r),
        )
            : InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(13.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 1),

          borderRadius: BorderRadius.circular(13.r),
        ),
      ),
    );
  }
}
