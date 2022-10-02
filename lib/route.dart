import 'package:flutter/material.dart';
import 'screens/create_profile.dart';
import 'screens/forgot_password.dart';
import 'screens/reset_password.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/home.dart';

class RouteGenerator {
  static const String home = "./screens/home.dart";
  static const String signIn = "./screens/sign_in.dart";
  static const String signUp = "./screens/sign_up.dart";
  static const String createProfile = "./screens/create_profile.dart";
  static const String settingPage = "./screens/settings.dart";
  static const String forgotPassword = "./screens/forgot_password.dart";
  static const String resetPassword = "./screens/reset_password.dart";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case settingPage:
        return MaterialPageRoute(builder: (_) => const Settings());
      case createProfile:
        return MaterialPageRoute(builder: (_) => const CreateProfile());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
