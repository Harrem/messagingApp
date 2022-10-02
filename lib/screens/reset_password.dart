import 'package:flutter/material.dart';
import 'package:assignment/route.dart';
import 'package:provider/provider.dart';
import '../controller/authentication.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    bool lightTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
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
      child: Scaffold(
        backgroundColor: lightTheme ? Colors.transparent : Colors.white,
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
                  "Email Sent!",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Follow the link that we sent to your email",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 100),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, RouteGenerator.signIn);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("DONE"),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
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
