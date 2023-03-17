import 'dart:ffi';

import 'package:carenet/Screens/extras.dart';
import 'package:carenet/Screens/heart_rate_monitor/heartRateMonitor.dart';
import 'package:carenet/Screens/profile.dart';
import 'package:carenet/Screens/reminder_screen.dart';
import 'package:carenet/Theming/customColors.dart';
import 'package:carenet/authentication/google_sign_in.dart';
import 'package:carenet/main.dart';
import 'package:carenet/screens/locationPage.dart';
import 'package:carenet/storage/cloudStorageTest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime datetime = DateTime.now();
String datetime3 = DateFormat.MMMMEEEEd().format(datetime);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 0, 0),
              child: Text(
                datetime3,
                style: TextStyle(color: CustomColors.grey1, fontSize: 16.sp),
              ),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage())),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 0),
                    //   child: CircleAvatar(
                    //       radius: 18.w,
                    //       backgroundImage: NetworkImage(user!.photoURL!),
                    // ),
//Disabled as email login doesn't have 'user' property breaking the entire app
                  ))
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 20.h),
          child: SingleChildScrollView(
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome Back! 👋🏻",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 255, 233, 233),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    "Measure your pulse rate using your camera!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HeartRateMon())),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent),
                                  child: Text("Measure Rate"))
                            ],
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          SvgPicture.asset(
                            "assets/images/heart_monitor.svg",
                            width: 70.w,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    "Save all your medical records in a secure vault and share with doctors easily!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  )),
                              SizedBox(
                                height: 14.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CloudStoragePage()));
                                  },
                                  child: Text("Upload Records"))
                            ],
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          SvgPicture.asset(
                            "assets/images/med_rec.svg",
                            width: 70.w,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: CustomColors.grey1,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    "Share your Live Location easily with your family!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocationPage())),
                                child: Text(
                                  "Share Location",
                                  style: TextStyle(color: CustomColors.grey2),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          SvgPicture.asset(
                            "assets/images/loc_track.svg",
                            width: 70.w,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.w),
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    "Do not forget to take your pills now!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Reminder())),
                                  child: Text("Set Reminders"))
                            ],
                          ),
                          SizedBox(
                            width: 35.w,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              "assets/images/reminders.svg",
                              width: 65.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
