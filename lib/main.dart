import 'dart:async';
import 'package:assignment/controller/bottom_nav_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

import 'route.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/conversation_actions.dart';
import 'controller/theme_controller.dart';
import 'controller/authentication.dart';
import 'controller/user_profile_actions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  late StreamSubscription<User?> _sub;

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        var userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        if (userData.exists) {
          debugPrint("data exist");
          navigatorKey.currentState!.pushReplacementNamed(RouteGenerator.home);
        } else {
          navigatorKey.currentState!
              .pushReplacementNamed(RouteGenerator.createProfile);
        }
      } else {
        navigatorKey.currentState!.pushReplacementNamed(RouteGenerator.signIn);
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavController>(
            create: (context) => BottomNavController()),
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider<ConversationActions>(
            create: (context) => ConversationActions()),
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<UserActions>(create: (context) => UserActions()),
      ],
      child: Consumer<ThemeController>(
        builder: (((context, value, child) {
          if (value.isDefault) {
            var sysBrightness =
                SchedulerBinding.instance.window.platformBrightness;
            value.setSysThemeMode(sysBrightness == Brightness.dark);
          }
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser != null
                ? RouteGenerator.loadingPage
                : RouteGenerator.signIn,
            onGenerateRoute: (settings) =>
                RouteGenerator.generateRoute(settings),
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Messenger',
            theme: value.themeData,
          );
        })),
      ),
    );
  }
}
