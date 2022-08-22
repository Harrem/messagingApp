import 'package:assignment/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Auth auth = Auth();
  TextEditingController usernameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  bool? lightTheme;
  @override
  Widget build(BuildContext context) {
    lightTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: lightTheme!
          ? const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 40, 80, 110),
                Color.fromARGB(255, 23, 47, 73),
              ],
            ))
          : const BoxDecoration(),
      child: Scaffold(
        backgroundColor: !lightTheme! ? Colors.white : Colors.transparent,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Sign in to continue",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: usernameText,
                  decoration: const InputDecoration(labelText: "USERNAME"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordText,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "PASSWORD"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var email = usernameText.text;
                    var password = passwordText.text;

                    User? user = await auth
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .onError(
                      (error, stackTrace) async {
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            content: Text("$error"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context)
                                      .clearMaterialBanners();
                                },
                                child: const Text("Dismiss"),
                              )
                            ],
                          ),
                        );
                        await Future.delayed(const Duration(seconds: 3));
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("PROCEED"),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    auth.signout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("PROCEED"),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?"),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Create Account"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
