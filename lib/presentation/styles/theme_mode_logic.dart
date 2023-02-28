import 'package:flutter/material.dart';
import '../../main.dart';

// ignore: constant_identifier_names
const String THEME_KEY = "theme_key";

class ModelTheme extends ChangeNotifier {
  String _currentTheme = ThemeMode.system.name;
  ThemeMode get themeMode {
    if (_currentTheme == ThemeMode.light.name) {
      return ThemeMode.light;
    } else if (_currentTheme == ThemeMode.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeCurrentTheme(String value) {
    _currentTheme = value;
    globalSharedPrefs!.setString(THEME_KEY, value);
    notifyListeners();
  }

  void getCurrentTheme() {
    _currentTheme = globalSharedPrefs!.getString(THEME_KEY) ?? 'system';
    notifyListeners();
  }
}
