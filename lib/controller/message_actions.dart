import 'package:assignment/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageActions extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String text) async {
    Message message =
        Message(text: text, sentDate: DateTime.now(), read: false);
    firestore.collection("conversations").doc().set(message.toMap());
    debugPrint("message Sent");
  }

  Stream<void> getMessages() async* {
    debugPrint('Getting message is active');
  }
}
