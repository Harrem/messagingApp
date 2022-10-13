import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/conversations.dart';

class ConversationActions extends ChangeNotifier {
  Future<List<Conversation>> getConversations() async {
    var docRef = FirebaseFirestore.instance.collection("users").doc().get();
    var doc = await docRef;
    var data = doc.data();
    var conversations = data!['conversations']
        .map((e) => Conversation.fromMap(e.data()))
        .toList();
    return conversations;
  }
}
