import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment/services/cloudStore.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  FirebaseFirestore firestore = CloudStore().firestore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: double.infinity,
                child: StreamBuilder(
                  stream: CloudStore().readMessage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        child: Text(snapshot.data['messages']),
                      );
                    }
                    return Text("failed");
                  },
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Text("bottom"),
                ))
          ],
        ),
      ),
    );
  }
}
