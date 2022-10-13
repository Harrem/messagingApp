import 'package:assignment/controller/conversation_actions.dart';
import 'package:assignment/controller/theme_controller.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/route.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    final conversationActions = Provider.of<ConversationActions>(context);
    userActions.getUserData();

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
                child: const OvalPicture(size: 50),
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
                child: FutureBuilder(builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: const [
                              ConvTile(),
                              SizedBox(height: 15),
                            ],
                          );
                        }),
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
          ),
          bottomNavigationBar: BottomAppBar(
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (value) {
                setState(() {
                  index = value;
                });
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
