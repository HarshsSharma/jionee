import 'package:flutter/material.dart';
import '../../main.dart';

// ignore: constant_identifier_names
const String THEME_KEY = "theme_key";
// ignore: constant_identifier_names
const String Font_KEY = "font_key";

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

  double _textScaleFactor = 1.0;
  double get textScaleFactor => _textScaleFactor;

  void _changeTextScaleFactor(double newValue) {
    _textScaleFactor = newValue;
    globalSharedPrefs!.setDouble(Font_KEY, newValue);
    notifyListeners();
  }

  void smallTextScaleFactor() => _changeTextScaleFactor(0.8);
  void regularTextScaleFactor() => _changeTextScaleFactor(1.0);
  void mediumTextScaleFactor() => _changeTextScaleFactor(1.2);
  void largeTextScaleFactor() => _changeTextScaleFactor(1.5);

  void getCurrentTheme() {
    _currentTheme = globalSharedPrefs!.getString(THEME_KEY) ?? 'system';
    _textScaleFactor = globalSharedPrefs!.getDouble(Font_KEY) ?? 1.0;
    notifyListeners();
  }
}
