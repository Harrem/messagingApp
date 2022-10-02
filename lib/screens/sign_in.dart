import 'package:flutter/material.dart';
import 'package:assignment/controller/authentication.dart';
import 'package:provider/provider.dart';
import '../route.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController usernameText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    bool lightTheme = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: lightTheme ? Colors.white : Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: lightTheme
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
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
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
                        var email = usernameText.text.trim();
                        var password = passwordText.text;

                        await auth
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .onError(
                          (error, stackTrace) async {
                            bool isShown = true;
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                content: Text("$error"),
                                actions: [
                                  //remove banner when pressed
                                  TextButton(
                                    onPressed: () async {
                                      isShown = false;
                                      ScaffoldMessenger.of(context)
                                          .clearMaterialBanners();
                                    },
                                    child: const Text("Dismiss"),
                                  )
                                ],
                              ),
                            );
                            // remove banner after 3 seconds
                            if (isShown) {
                              await Future.delayed(const Duration(seconds: 3));
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .clearMaterialBanners();
                            }
                          },
                        );
                        if (auth.checkUser()) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed(RouteGenerator.home);
                        } else {
                          debugPrint("an error occured when signing in!");
                        }
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        // color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteGenerator.forgotPassword);
                              },
                              child: const Text("Forgot Password?"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.signUp);
                              },
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
        ),
      ),
    );
  }
}
