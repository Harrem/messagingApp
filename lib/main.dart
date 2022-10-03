import 'dart:async';
import 'controller/authentication.dart';
import 'controller/user_profile_actions.dart';
import 'route.dart';
import 'theme/custom_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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

    _sub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        navigatorKey.currentState!.pushReplacementNamed(RouteGenerator.home);
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
        ChangeNotifierProvider<Auth>(create: ((context) => Auth())),
        ChangeNotifierProvider<UserActions>(create: (context) => UserActions()),
      ],
      child: MaterialApp(
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? RouteGenerator.home
            : RouteGenerator.signIn,
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Messenger',
        theme: CustomTheme().darkTheme,
      ),
    );
  }
}
