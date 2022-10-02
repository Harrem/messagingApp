import 'package:flutter/material.dart';
import 'package:assignment/route.dart';
import 'package:provider/provider.dart';
import '../controller/authentication.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    bool lightTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: lightTheme ? Colors.transparent : Colors.white,
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
                  ),
                )
              : const BoxDecoration(),
          child: Center(
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
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    "Enter your email to continue",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: usernameText,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var email = usernameText.text;

                      await auth
                          .sendPasswordResetEmail(email)
                          .then((value) => Navigator.pushNamed(
                              context, RouteGenerator.resetPassword))
                          .onError(
                        (error, stackTrace) async {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Text("$error"),
                              actions: [
                                TextButton(
                                  onPressed: () {
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
                                  context, RouteGenerator.signIn);
                            },
                            child: const Text("Sign In"),
                          ),
                          const Text(""),
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
    );
  }
}
