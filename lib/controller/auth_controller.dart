import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {



  RxString signupName = "".obs;
  RxString signupEmail = "".obs;
  RxString signupPass = "".obs;
  RxString profileURL = "".obs;
  RxString authPhoneNumber = "".obs;

  RxString verificationIdCode = "".obs;
  RxString level = "".obs;
  RxString completePhoneNumber = "".obs;

  RxInt resendTokenCode = 0.obs;
  RxBool allSignInField = false.obs;
  RxBool allLoginInField = false.obs;

  RxBool signingUp = false.obs;
  RxBool fromLogin = false.obs;

  RxString sentOTP = "".obs;
  RxString recievedOTP = "".obs;
  final Rx<TextEditingController> otpController = TextEditingController().obs;

  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> username = TextEditingController().obs;
  final Rx<TextEditingController> newPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
}