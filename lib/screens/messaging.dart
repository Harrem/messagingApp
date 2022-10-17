import 'package:assignment/controller/conversation_actions.dart';
import 'package:assignment/controller/user_profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:assignment/services/cloudStore.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CloudStore store = CloudStore();
  String message = "";
  String username = "";
  @override
  Widget build(BuildContext context) {
    final userActions = Provider.of<UserActions>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Harrem"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: FutureBuilder(
                  builder: (context, snapshot) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    //  snapshot.data.docs.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[900]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Harrem Mhamad",
                              // snapshot.data.docs[index]['user'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "yo, sup?",
                              // snapshot.data.docs[index]['msg'],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      );
                    }),
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
                            username = value;
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
                              if (message.isNotEmpty && username.isNotEmpty) {
                                store.writeMessage(message, username);
                                _formKey.currentState!.reset();
                              }
                              setState(() {
                                if (message.isEmpty || username.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
    );
  }
}
