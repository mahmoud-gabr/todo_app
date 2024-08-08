import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = const Color(0xFF5D9CEC);
  static Color backgroundLight = const Color(0xFFDFECDB);
  static Color backgroundDark = const Color(0xFF060E1E);
  static Color white = const Color(0xFFFFFFFF);
  static Color grey = const Color(0xFFC8C9CB);
  static Color green = const Color(0xFF61E757);
  static Color red = const Color(0xFFEC4B4B);
  static Color black = const Color(0xFF000000);


  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          width: 4,
          color: white,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: white,
        ),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
