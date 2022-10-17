import 'package:assignment/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeController extends ChangeNotifier {
  bool _lightMode = true;
  bool isDefault = true;
  ThemeData themeData = CustomTheme().lightTheme;

  void disableDefualt() {
    isDefault = false;
  }

  void enableDefualt() {
    isDefault = true;
  }

  void turnThemeMode() {
    _lightMode = !_lightMode;
    _lightMode
        ? themeData = CustomTheme().lightTheme
        : themeData = CustomTheme().darkTheme;
    notifyListeners();
  }

  void setSysThemeMode(bool isDark) {
    _lightMode = !isDark;
    _lightMode
        ? themeData = CustomTheme().lightTheme
        : themeData = CustomTheme().darkTheme;
  }
}
