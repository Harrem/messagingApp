import 'package:flutter/material.dart';
import 'package:assignment/controller/authentication.dart';
import 'package:provider/provider.dart';
import '../route.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    bool lightTheme = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: !lightTheme ? Colors.white : Colors.transparent,
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
                constraints: const BoxConstraints(maxWidth: 700),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                child: Form(
                  key: _formkey,
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
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "EMAIL"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please Enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: "PASSWORD"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            var email = emailController.text.trim();
                            var password = passwordController.text;

                            await auth
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .onError(
                              (error, stackTrace) async {
                                bool isShown = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("$error"),
                                    action: SnackBarAction(
                                      label: 'Dismiss',
                                      //remove banner when pressed
                                      onPressed: () async {
                                        isShown = false;
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                      },
                                    ),
                                  ),
                                );
                                // remove banner after 3 seconds
                                if (isShown) {
                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .clearMaterialBanners();
                                }
                              },
                            );
                            if (auth.checkUser()) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteGenerator.home);
                            } else {
                              debugPrint("an error occured when signing in!");
                            }
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
      ),
    );
  }
}
