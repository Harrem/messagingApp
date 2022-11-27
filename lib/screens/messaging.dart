import 'package:assignment/controller/conversation_actions.dart';
import 'package:assignment/controller/loading_provider.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:assignment/models/conversations.dart';
import 'package:assignment/models/message.dart';
import 'package:assignment/models/user_data.dart';
import 'package:assignment/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment/services/cloudStore.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.toUser}) : super(key: key);
  final UserData toUser;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CloudStore store = CloudStore();
  String message = "";
  String? cid;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    return ChangeNotifierProvider<Loading>(
      create: (context) => Loading(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: checkConv(
                    userActions.userData, userActions.uid, widget.toUser.uid) ==
                null
            ? CreateConversationWidget(withUser: widget.toUser)
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[900]),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: store.firestore
                                .collection('conversations')
                                .doc(cid!)
                                .collection('messages')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  debugPrint("empty Stream");
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      reverse: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                  (snapshot.data!.docs[index]
                                                          .data()
                                                      as Map<String,
                                                          dynamic>)['msg'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                              leading: Text(
                                                "uid",
                                                // snapshot.data.docs[index]['user'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        );
                                      });
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    message = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "User Name",
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      if (message.isNotEmpty) {
                                        store.writeMessage(
                                            message, cid!, userActions.uid);
                                        _formKey.currentState!.reset();
                                      }
                                      setState(() {
                                        if (message.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Fields are Empty'),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Conversation? checkConv(UserData userData, String uid1, String uid2) {
    Conversation? conversation;

    for (var conv in userData.conversations) {
      if (conv.user1 == uid1 && conv.user2 == uid2) {
        conversation = conv;
      } else if (conv.user2 == uid1 && conv.user1 == uid2) {
        conversation = conv;
      }
    }
    cid = conversation?.cid;
    return conversation;
  }
}

class CreateConversationWidget extends StatelessWidget {
  const CreateConversationWidget({super.key, required this.withUser});
  final UserData withUser;
  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<Loading>(context);
    final userActions = Provider.of<UserActions>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 300,
          child: Column(
            children: [
              OvalPicture(
                image: Image.network(withUser.profilePictureUrl),
                size: 125,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${withUser.firstName} ${withUser.lastName}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "You don't have conversation with ${withUser.firstName}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 5),
              Text(
                "Start a conversation right now",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              loadingProvider.start();
              debugPrint("started loading indicator");
              await userActions
                  .createConversation(userActions.uid, withUser.uid)
                  .then((value) {
                debugPrint("Conversation Created");
                debugPrint("Conversation id: ${value.cid}");
              });

              debugPrint("stopped loading indicator");
              loadingProvider.stop();
            },
            child: loadingProvider.isLoading
                ? const SizedBox(
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                : const Text("Start Conversation"),
          ),
        ),
      ],
    );
  }
}
