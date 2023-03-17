import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get lightTheme { 
    return ThemeData( 
      brightness: Brightness.light,
          drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue.shade300,
          cardColor: Colors.grey.shade200,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
          ),
    );
  }
}

class DarkTheme {
  static ThemeData get darkTheme { 
    return ThemeData( 
      brightness: Brightness.dark,
          drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade900),
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryColor: Colors.blue.shade200,
          cardColor: Colors.grey.shade800,
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
          ),
    );
  }
}

