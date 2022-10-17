import 'package:assignment/controller/conversation_actions.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchContoller = TextEditingController();

  var list = [];

  var text = '';

  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    final conversationActions = Provider.of<ConversationActions>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: searchContoller,
                  decoration: const InputDecoration(labelText: 'Search'),
                  onChanged: (value) async {
                    setState(() {
                      text = value;
                    });
                  },
                ),
                FutureBuilder<List<Map<String, dynamic>?>>(
                  future: userActions.search(text),
                  builder: ((context, snapshot) {
                    // debugPrint(snapshot.data!.length.toString());
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var fname = snapshot.data![index]!['firstName'];
                          var lname = snapshot.data![index]!['lastName'];
                          return InkWell(
                            onTap: () {
                              if (userActions.userData.conversations
                                  .contains(snapshot.data![index]!['uid'])) {}
                              userActions.createConversation(
                                  snapshot.data![index]!['uid']);
                              Navigator.pushNamed(
                                  context, RouteGenerator.messagePage);
                            },
                            child: ListTile(
                              title: Text("$fname $lname"),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text("Error while searching"),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
