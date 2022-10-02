import 'package:assignment/controller/authentication.dart';
import 'package:assignment/route.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          OvalPicture(size: 70),
          TextButton(
              onPressed: () {
                Auth().signout();
                if (Auth().firebaseAuth.currentUser == null) {
                  Navigator.pushNamed(context, RouteGenerator.signIn);
                }
              },
              child: const Text("Sign out")),
        ]),
      ),
    );
  }
}
