import 'package:assignment/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _lightMode = true;
  ThemeData themeMode = CustomTheme().lightTheme;

  void turnThemeMode() {
    _lightMode = !_lightMode;
    _lightMode
        ? themeMode = CustomTheme().lightTheme
        : themeMode = CustomTheme().darkTheme;
    notifyListeners();
  }
}
