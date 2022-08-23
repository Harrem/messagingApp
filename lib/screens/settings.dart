import 'package:assignment/controller/authentication.dart';
import 'package:assignment/screens/sign_in.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignIn(),
                    ),
                  );
                }
              },
              child: const Text("Sign out")),
        ]),
      ),
    );
  }
}
