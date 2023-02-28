import 'package:flutter/material.dart';
import '../../constants/enums/model_theme.dart';
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

  double _textScaleFactor = TextScaleFactorValue.reqular.scaleValue;
  double get textScaleFactor => _textScaleFactor;

  void _changeTextScaleFactor(double newValue) {
    _textScaleFactor = newValue;
    globalSharedPrefs!.setDouble(Font_KEY, newValue);
    notifyListeners();
  }

  void smallTextScaleFactor() => _changeTextScaleFactor(TextScaleFactorValue.small.scaleValue);
  void regularTextScaleFactor() => _changeTextScaleFactor(TextScaleFactorValue.reqular.scaleValue);
  void mediumTextScaleFactor() => _changeTextScaleFactor(TextScaleFactorValue.medium.scaleValue);
  void largeTextScaleFactor() => _changeTextScaleFactor(TextScaleFactorValue.large.scaleValue);

  void getCurrentTheme() {
    _currentTheme = globalSharedPrefs!.getString(THEME_KEY) ?? ThemeMode.system.name;
    _textScaleFactor = globalSharedPrefs!.getDouble(Font_KEY) ?? 1.0;
    notifyListeners();
  }
}
