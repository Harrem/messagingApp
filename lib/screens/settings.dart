import 'package:assignment/controller/authentication.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/route.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserActions>(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const OvalPicture(size: 70),
              TextButton(
                onPressed: () {
                  Auth().signout();
                  if (Auth().firebaseAuth.currentUser == null) {
                    Navigator.pushNamed(context, RouteGenerator.signIn);
                  }
                },
                child: const Text("Sign out"),
              ),
              Text(
                  "${userProvider.userData.firstName} ${userProvider.userData.lastName}")
            ],
          ),
        ),
      ),
    );
  }
}
