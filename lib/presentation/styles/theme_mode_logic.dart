import 'package:flutter/material.dart';

import '../../data/date_providers/local/cache_helper.dart';

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
    CacheHelper.saveDataSharedPreference(key: THEME_KEY, value: value);
    notifyListeners();
  }

  Future<void> getCurrentTheme() async {
    _currentTheme =
        await CacheHelper.getDataFromSharedPreference(key: THEME_KEY) ??
            'system';
    notifyListeners();
  }
}
