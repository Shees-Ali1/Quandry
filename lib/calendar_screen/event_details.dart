import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quandry/const/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/const/textstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.asset(
                "assets/images/partyy.png",
                width: double.infinity,
              ),
              Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/event_back.png',
                        height: 36.h,
                      ))),
              Positioned(
                  bottom: 35.h,
                  left: 18.w,
                  child: Text(
                    'Utah Fall Conference on\nSubstance Us',
                    style: jost700(26.sp, Color.fromRGBO(255, 255, 255, 1)),
                    maxLines: 2,
                  )),
            ]),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.w,top: 16.h),
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(216, 229, 236, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          topLeft: Radius.circular(12.r)),),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Icon(FontAwesomeIcons.calendarDay, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text('Oct 23-25,2024',
                              style: montserrat600(14.sp, AppColors.blueColor),
                            ),
                            SizedBox(width: 105.w,),
                            Image.asset('assets/images/singlestar.png',height: 18.h,width: 18.w,),
                            Text(' 4',style: jost600(14.sp, AppColors.blueColor),),
                            Text(' (15)',style: jost400(14.sp, AppColors.blueColor),)


                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text('St.George, UT', style: jost600(14.sp, AppColors.blueColor),),
                            SizedBox(width: 70.w),
                            FaIcon(
                              FontAwesomeIcons.bookOpen, // Use the Font Awesome book icon
                              size: 14.sp,
                              color: AppColors.blueColor,
                            ),
                            SizedBox(width: 5.w),
                            Text('10 CE Credits', style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.tag, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text('Free - \$500/seat', style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.ticket, size: 14.0.sp, color: AppColors.blueColor),
                            SizedBox(width: 13.w),
                            Text('Dixie Convention Center', style: jost600(14.sp, AppColors.blueColor),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 36.w),
                    height: 37.h,
                    decoration: BoxDecoration(color: AppColors.blueColor,borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r)),),
                    child: Row(
                      children: [
                        Image.asset('assets/images/person_check.png',height: 16.h,width: 14.w,),
                        SizedBox(width: 7.w,),
                        Text('Utah Mental Health Counselors Association',style: montserrat600(10.sp, AppColors.whiteColor),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(22.w, 0.h, 31.w, 0.w),
                    //  padding: EdgeInsets.all(22),
                    height: 101.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 22.0.h),
                          child: Column(
                            children: [
                              Text(
                                "Following",
                                style:
                                jost600(14.sp, AppColors.backgroundColor),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "17",
                                style:
                                jost700(24.sp, AppColors.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 101.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(10, 42, 58, 1.0), // Top color
                                Color.fromRGBO(
                                    216, 229, 236, 1.0), // Middle color
                                Color.fromRGBO(10, 42, 58, 1.0), // Bottom color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.505, 1.0],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 22.0.h),
                          child: Column(
                            children: [
                              Text(
                                "Planned",
                                style:
                                jost600(14.sp, AppColors.backgroundColor),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "9",
                                style:
                                jost700(24.sp, AppColors.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 101.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(10, 42, 58, 1.0), // Top color
                                Color.fromRGBO(
                                    216, 229, 236, 1.0), // Middle color
                                Color.fromRGBO(10, 42, 58, 1.0), // Bottom color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.505, 1.0],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 22.0.h),
                          child: Column(
                            children: [
                              Text(
                                "Favorited",
                                style:
                                jost600(14.sp, AppColors.backgroundColor),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "3",
                                style:
                                jost700(24.sp, AppColors.backgroundColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Description',
                        style: jost700(16.sp, AppColors.blueColor),
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    '43 Years Strong: Elevate Your Substance Use Expertise! Escape to the vibrant red rock country for a program unlike any others. This 43-year tradition brings together passionate professionals– from prevention pioneers to treatment champions, recovery advocates, and wellness warriors.',
                    style: jost400(14.sp, Color.fromRGBO(52, 51, 51, 1)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Estimated CE Credits:',
                        style: jost700(16.sp, AppColors.blueColor),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 76.h,
                        width: 161.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 13.w, ),
                              height: 37.h,
                              width: 161.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    topLeft: Radius.circular(12.r)),
                              ),
                              child: Row(

                                children: [
                                  Text('Substance Abuse',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10.sp,color: Colors.white),),
                                  SizedBox(width: 28.w,),
                                  Text('8',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30.sp,color: Colors.white,),),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.w, ),
                              decoration: BoxDecoration(
                                color: AppColors.appbar_text,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                              ),
                              height: 37.h,
                              child: Row(
                                children: [Image.asset('assets/images/check.png',height: 11.h,width: 11.w,),
                                  SizedBox(width: 5.w,),
                                  Text('American Physchology\nAssociation (APA)',style: montserrat600(8.sp, AppColors.blueColor),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 76.h,
                        width: 161.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 13.w, ),
                              height: 37.h,
                              width: 161.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    topLeft: Radius.circular(12.r)),
                              ),
                              child: Row(

                                children: [
                                  Text('Addiction Treatment',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10.sp,color: Colors.white),),
                                  SizedBox(width: 10.w,),
                                  Text('4',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30.sp,color: Colors.white,),),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.w, ),
                              decoration: BoxDecoration(
                                color: AppColors.appbar_text,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r)),
                              ),
                              height: 37.h,
                              child: Row(
                                children: [Image.asset('assets/images/check.png',height: 11.h,width: 11.w,),
                                  SizedBox(width: 5.w,),
                                  Text('American Physchology\nAssociation (APA)',style: montserrat600(8.sp, AppColors.blueColor),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 46.h,
                        width: 171.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/heart.png',
                                height: 21.h,
                                width: 25.w,
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              Text(
                                'Favorite',
                                style: jost700(16.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 46.h,
                        width: 171.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/eye.png',
                                height: 32.h,
                                width: 32.w,
                              ),
                              SizedBox(
                                width: 23.w,
                              ),
                              Text(
                                'Follow',
                                style: jost700(16.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 46.h,
                        width: 171.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(22.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 9.w),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/circle.png',
                                height: 30.h,
                                width: 30.w,
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Text(
                                "I'm going",
                                style: jost700(14.sp, Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Container(
                        height: 46.h,
                        width: 171.h,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(22.r)),
                        child:     Padding(
                          padding:  EdgeInsets.only(left: 9.w),
                          child: Row(
                            children: [
                              Container(height: 30.h,width: 30.w,decoration: BoxDecoration(
                                  color: AppColors.blueColor,shape: BoxShape.circle,border: Border.all(width: 3.w,color: Colors.white)
                              ),
                                child: Icon(Icons.check,color: Colors.white,size: 15.sp,),
                              ),
                              SizedBox(width: 14.w,),
                              Text("I went to this",style:jost700(14.sp, Colors.white) ,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    //  height: 140.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(216, 229, 236, 1),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      children: [
                        SizedBox(height: 9.h,),
                        Text('Attended this Event Previously?',style: montserrat600(12.sp, AppColors.blueColor),),
                        SizedBox(height: 8.h,),
                        Container(
                          padding: EdgeInsets.only(left: 17.w,),
                          height: 55.h,
                          width: 229.w,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                          child: Row(

                            children: [
                              Image.asset('assets/images/stars.png',height: 26.h,width: 146.w,),
                              Text('4 out of 5',style: jost500(9.sp,  Colors.white) ,)
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Container(
                          height: 34.h,
                          width: 105.w,
                          decoration: BoxDecoration(color: AppColors.blueColor,borderRadius: BorderRadius.circular(10.r)),
                          child: Center(child: Text('Rate',style: montserrat600(12.sp, AppColors.whiteColor),)),
                        ),
                        SizedBox(height: 11.h,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}