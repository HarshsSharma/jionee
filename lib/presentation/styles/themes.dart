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
    useMaterial3: true,
    colorScheme: _lightColorScheme(),
    appBarTheme: _appBarTheme().copyWith(
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
    textTheme: TextTheme(
      titleLarge: _titleLarge(Colors.black),
      titleMedium: _titleMedium(),
      headlineSmall: _headlineSmall(Colors.black),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme(),
    appBarTheme: _appBarTheme(),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
    dialogBackgroundColor: Colors.grey[700],
    textTheme: TextTheme(
      titleLarge: _titleLarge(Colors.white),
      titleMedium: _titleMedium(),
      headlineSmall: _headlineSmall(Colors.white),
    ),
  );
}

// Color Scheme For Light and Dark Mode
ColorScheme _lightColorScheme() => const ColorScheme(
      background: AppColors.scaffoldBackgroundColor,
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      surface: AppColors.primaryColor,
    );

ColorScheme _darkColorScheme() => ColorScheme(
      background: Colors.black,
      brightness: Brightness.dark,
      surfaceVariant: Colors.red,
      error: Colors.red,
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primary: Colors.grey[850]!,
      secondary: Colors.grey[850]!,
      surface: Colors.black,
    );

// BottomNav Theme Mode is the sama for both light and dark themes
BottomNavigationBarThemeData _bottomNavigationBarThemeData() =>
    const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 0),
      unselectedLabelStyle: TextStyle(fontSize: 0),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    );

// App bar Theme Mode is the sama for both light and dark themes
AppBarTheme _appBarTheme() => const AppBarTheme(
      elevation: 0.0,
    );

// Text Style for themes
TextStyle _headlineSmall(Color color) => _getTextStyle(
      fontSize: 18.0,
      color: color,
      fontWeight: FontWeight.w400,
    );

TextStyle _titleMedium() => _getTextStyle(
      fontSize: 16.0,
      color: AppColors.tDarkGrey,
    );

TextStyle _titleLarge(Color color) => _getTextStyle(
      fontSize: 18.0,
      color: color,
      fontWeight: FontWeight.bold,
    );
