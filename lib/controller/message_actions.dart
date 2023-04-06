import 'package:assignment/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageActions extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String text, String toUid, String fromUid, String cid) async {
    Message message = Message(
        cid: cid,
        fromUid: fromUid,
        text: text,
        sentDate: DateTime.now(),
        didRead: false,
        isDelivered: false);
    firestore.collection("conversations").doc().set(message.toMap());
    debugPrint("message Sent");
  }

  Stream<void> getMessages() async* {
    debugPrint('Getting message is active');
  }
}
