import 'package:flutter/material.dart';

///Custom Theme Data for light and  Dark Theme Mode
class CustomTheme {
  var borderRadius = 7.0;
  var inputPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 24);
  var buttonPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 25);
//Light mode
  ThemeData get lightTheme {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 35, 76, 110),
          background: Color.fromRGBO(232, 234, 246, 1),
        ),
        brightness: Brightness.light,
        // scaffoldBackgroundColor: Colors.indigo[50],
        textTheme: const TextTheme(
          headline4: TextStyle(
              color: Color.fromARGB(255, 36, 73, 100),
              fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: Colors.grey),
        ),
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: inputPadding,
          filled: true,
          fillColor: const Color.fromARGB(255, 242, 244, 246),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
            gapPadding: 50,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: buttonPadding,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide.none,
          ),
        ));
  }

// Dark Mode
  ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 220, 220, 220),
      ),
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headline4: TextStyle(color: Colors.white),
        subtitle2: TextStyle(
          color: Colors.grey,
        ),
      ),
      dividerTheme: const DividerThemeData(color: Colors.transparent),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: inputPadding,
        filled: true,
        fillColor: const Color.fromARGB(20, 255, 255, 255),
        labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 110, 130, 150)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
          gapPadding: 50,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide.none,
        ),
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
