import 'package:assignment/controller/bottom_nav_controller.dart';
import 'package:assignment/controller/theme_controller.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/models/conversations.dart';
import 'package:assignment/route.dart';
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
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Chats",
              style: Theme.of(context).textTheme.headline6,
            ),
            leading: Container(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteGenerator.settingPage);
                },
                child: OvalPicture(
                    image: userActions.userData.profilePictureUrl.isNotEmpty
                        ? Image.network(userActions.userData.profilePictureUrl)
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
          body: FutureBuilder(
            future: userActions.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Happened"));
              }
              return Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<Conversation>?>(
                        future: userActions.getConversations(),
                        builder: (context, snapshot) {
                          final covs = snapshot.data;

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      ConvTile(
                                        title: snapshot
                                            .data![index].conversationId,
                                        lastMessage:
                                            covs![index].messages.isNotEmpty
                                                ? covs[index].messages.last.text
                                                : "no messages",
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  );
                                }),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else {
                              return const Center(
                                child: Text("Data is null"),
                              );
                            }
                          }
                          return const Center(
                            child: Text("Connnection Error"),
                          );
                        }),
                  )
                ],
              );
            },
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
        ),
      ),
    );
  }
}
