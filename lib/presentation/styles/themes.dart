import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle _getTextStyle({
  required double fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 0),
      unselectedLabelStyle: TextStyle(fontSize: 0),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: _getTextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: _getTextStyle(
        fontSize: 16.0,
        color: AppColors.tDarkGrey,
      ),
      headlineSmall: _getTextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 0),
      unselectedLabelStyle: TextStyle(fontSize: 0),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: _getTextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: _getTextStyle(
        fontSize: 16.0,
        color: AppColors.tDarkGrey,
      ),
      headlineSmall: _getTextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
