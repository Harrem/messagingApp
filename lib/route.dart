import 'package:assignment/screens/home.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String home = "./screens/home.dart";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
