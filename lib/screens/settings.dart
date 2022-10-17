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
    final userActions = Provider.of<UserActions>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.info_outline)),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const Icon(Icons.edit),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteGenerator.editProfilePic);
                    },
                    child: OvalPicture(
                        image: userActions.userData.profilePictureUrl.isNotEmpty
                            ? Image.network(
                                userActions.userData.profilePictureUrl)
                            : null,
                        size: 130),
                  ),
                ],
              ),
              const Divider(),
              const Divider(),
              Text(
                "${userActions.userData.firstName} ${userActions.userData.lastName}",
                style: Theme.of(context).textTheme.headline5,
              ),
              const Divider(),
              const ListTile(
                title: Text("System Theme"),
                leading: Icon(Icons.brightness_6),
              ),
              const Divider(),
              OutlinedButton(
                onPressed: () {
                  Auth().signout().then((value) =>
                      Navigator.pushNamed(context, RouteGenerator.signIn));
                  // if (Auth().firebaseAuth.currentUser == null) {
                  // }
                },
                child: const Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
