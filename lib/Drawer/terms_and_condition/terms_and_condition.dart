import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/widgets/appbar_small.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSmall(
        iconImage: AppImages.back_icon, // Set your custom back icon
        onIconTap: () {
          Get.back();
        },
        iconHeight: 15.h, // Custom height
        iconWidth: 20.w,
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
                  child: Image.asset(AppImages.quanderyLogo),
                ),
              ),
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
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
                  padding: EdgeInsets.all(12.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTermsSection(
                        "1. Acceptance of Terms",
                        "By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of the Terms, you may not access the Service.",
                      ),
                      _buildTermsSection(
                        "2. Accounts",
                        "To use some parts of the Service, you may be required to create an account. You must provide accurate, complete, and current information at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.",
                      ),
                      _buildTermsSection(
                        "3. Privacy Policy",
                        "Our Privacy Policy explains how we collect, use, and disclose information that pertains to your privacy. By using the Service, you agree to our Privacy Policy.",
                      ),
                      _buildTermsSection(
                        "4. User Content",
                        "You are responsible for the content you post on the Service, including its legality, reliability, and appropriateness. By posting content, you grant us the right and license to use, modify, and display such content on the Service.",
                      ),
                      _buildTermsSection(
                        "5. Prohibited Activities",
                        "You agree not to engage in activities such as:\n\n- Violating any applicable laws or regulations.\n- Attempting to gain unauthorized access to the Service.\n- Interfering with the security of the Service.",
                      ),
                      _buildTermsSection(
                        "6. Intellectual Property",
                        "All intellectual property rights in the Service and its contents (excluding User Content) are owned by [App Name] or its licensors. You may not use our trademarks, logos, or any other content without our prior written consent.",
                      ),
                      _buildTermsSection(
                        "7. Subscriptions and Fees",
                        "Some parts of the Service are billed on a subscription basis. You will be billed in advance on a recurring basis, in accordance with the plan you select. You may cancel your Subscription at any time through your account settings.",
                      ),
                      _buildTermsSection(
                        "8. Termination",
                        "We may terminate or suspend your account without prior notice if you violate these Terms. Upon termination, your right to use the Service will immediately cease.",
                      ),
                      _buildTermsSection(
                        "9. Limitation of Liability",
                        "In no event shall [App Name], its directors, employees, or partners be liable for any indirect or consequential damages, or any loss of data, use, or profits, arising out of your use of the Service.",
                      ),
                      _buildTermsSection(
                        "10. Changes to Terms",
                        "We reserve the right to modify or replace these Terms at any time. We will notify you of any changes by posting the new Terms on this page. Your continued use of the Service after the changes take effect will signify your acceptance of the new Terms.",
                      ),
                      _buildTermsSection(
                        "11. Governing Law",
                        "These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction]. Any disputes arising in connection with these Terms will be resolved in the courts of [Jurisdiction].",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}