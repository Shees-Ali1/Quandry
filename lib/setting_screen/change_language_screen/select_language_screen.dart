import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:quandry/widgets/appbar_small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/widgets/custom_button.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  int? selectedIndex;

  final List<Map<String, String>> languages = [
    {'name': 'English', 'flag': "assets/images/us_flag.jpg", 'code': 'en'},
    {'name': 'French', 'flag': "assets/images/france.jpg", 'code': 'fr'},
    {'name': 'Spanish', 'flag': "assets/images/spain.jpg", 'code': 'es'},
    {'name': 'Denmark', 'flag': "assets/images/denmark.png", 'code': 'de'},
    {'name': 'Denmark', 'flag': "assets/images/denmark.png", 'code': 'de'},
    {'name': 'Denmark', 'flag': "assets/images/denmark.png", 'code': 'de'},
    {'name': 'Denmark', 'flag': "assets/images/denmark.png", 'code': 'de'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSmall(
        title: "Languages",
        iconImage: AppImages.back_icon,
        onIconTap: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 11.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text(
              "Select Your Preferred Language",
              style: jost700(16.sp, AppColors.blueColor),
            ),
            SizedBox(height: 40.h),
            Container(
              height: 400.h,
              child: Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        print('Selected Language: ${language['name']}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric( vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.blueColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                language['flag']!,
                                width: 40,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              language['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                              Icons.check_circle,
                              color: AppColors.backgroundColor,
                              size: 24,
                            )
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 40.h),

            CustomButton(text: "Select", color: AppColors.blueColor, onPressed: (){

            }),
          ],
        ),
      ),
    );
  }
}
