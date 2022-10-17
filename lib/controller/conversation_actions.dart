import 'package:assignment/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConversationActions extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  String uid = "";

  void setMessageUserid(String uid) {
    this.uid = uid;
  }

  String getMessageUid() {
    return uid;
  }

  Future<void> createConversation(String toUid, UserData userData) async {
    final docRef =
        await firestore.collection("conversations").add({'toUid': toUid});
    final docId = docRef.id;
    DocumentReference ref = docRef;
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({'conversations': docRef});
  }

  // Future<List<Conversation>> getConversations() async {
  //   var docRef = FirebaseFirestore.instance.collection("users").doc(uid).get();
  //   var doc = await docRef;
  //   var data = doc.data();
  //   if (data == null) return Future.error('Start a conversation');
  //   List<Conversations> conversations = data['conversations']
  //       .map((e) => Conversation.fromMap(e.data()))
  //       .toList();
  //   return conversations;
  // }
}
