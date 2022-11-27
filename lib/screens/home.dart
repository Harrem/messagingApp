import 'package:assignment/controller/bottom_nav_controller.dart';
import 'package:assignment/controller/theme_controller.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/models/conversations.dart';
import 'package:assignment/models/with_user_data.dart';
import 'package:assignment/route.dart';
import 'package:assignment/services/cloudStore.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    final navController = Provider.of<BottomNavController>(context);
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: FutureBuilder(
            future: userActions.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Happened"));
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Chats",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteGenerator.settingPage);
                      },
                      child: OvalPicture(
                          image:
                              userActions.userData.profilePictureUrl.isNotEmpty
                                  ? Image.network(
                                      userActions.userData.profilePictureUrl)
                                  : null,
                          size: 50),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: IconButton(
                          onPressed: () {
                            Provider.of<ThemeController>(context, listen: false)
                                .turnThemeMode();
                          },
                          icon: const Icon(Icons.light_mode)),
                    )
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: userActions.userData.conversations.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          String? withUid;
                          if (userActions.userData.conversations[index].user1 !=
                              userActions.uid) {
                            withUid =
                                userActions.userData.conversations[index].user1;
                          } else {
                            withUid =
                                userActions.userData.conversations[index].user2;
                          }

                          return FutureBuilder<WithUserData>(
                            future: CloudStore().getWithUser(withUid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text(
                                    "Start Conversation with you friends",
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return snapshot.data == null
                                  ? const Center(
                                      child: Text("no data"),
                                    )
                                  : Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              RouteGenerator.messagePage,
                                              arguments: snapshot.data!,
                                            );
                                          },
                                          child: ConvTile(
                                            title: snapshot.data!.fullName,
                                            profileImage: Image.network(snapshot
                                                .data!.profilePictureUrl),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    );
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  child: BottomNavigationBar(
                    currentIndex: navController.index,
                    onTap: (value) {
                      navController.setIndex(value);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.phone),
                        label: "Calls",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: "Actives",
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.searchPage);
                  },
                  child: const Icon(Icons.search),
                ),
              );
            },
          ),
        ));
  }
}
