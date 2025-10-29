import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // default = dark
  SharedPreferences? _prefs;

  ThemeManager() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs!.getBool('isDarkTheme');
    if (isDark == true) {
      _themeMode = ThemeMode.dark;
    } else if (isDark == false) {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _prefs?.setBool('isDarkTheme', isDark);
    notifyListeners();
  }
}
