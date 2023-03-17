import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'customColors.dart';

class CustomTheme {
  // Retreiving class field and saving it in a variable

  static ThemeData get lightTheme {
    // Converting Color to MaterialColor
    

    return ThemeData(

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          padding: EdgeInsets.fromLTRB(30.w, 12.h, 30.w, 12.h)
        )
      ),
      
      // Color Theme
      colorScheme: const ColorScheme.light(
        primary: CustomColors.bluebell,
        secondary: CustomColors.grey2
      ),
      scaffoldBackgroundColor: Colors.white,

      // Text Theme
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: CustomColors.grey1),
        button: TextStyle(fontSize: 14.sp,fontWeight:FontWeight.w500,color: Colors.white ),
        bodyText2: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
        headline1: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w800, color: Colors.black),
        headline2: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w800,color: Colors.black),
        subtitle1: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: CustomColors.grey2),
        subtitle2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black)),
        
        
      
      // Fonts
      fontFamily: "Circular",
    );
  }
}
