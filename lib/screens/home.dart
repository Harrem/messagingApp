import 'package:assignment/screens/settings.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Divider(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Settings()));
                      },
                      child: const OvalPicture(size: 40)),
                  const VerticalDivider(),
                  Text(
                    "Chats",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              flex: 10,
              child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: ((context, index) {
                    return Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const OvalPicture(),
                            trailing:
                                const Icon(Icons.delivery_dining_outlined),
                            title: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TitleText("Profile Name"),
                                  Text(
                                    "Last Message",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
          ],
        ),
      ),
    );
  }
}
