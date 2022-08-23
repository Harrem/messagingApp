import 'package:assignment/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const OvalPicture(size: 40),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.search),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            label: "Messages",
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: "Contacts",
            icon: Icon(Icons.group),
          )
        ]));
  }
}
