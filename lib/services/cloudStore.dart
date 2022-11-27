import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void writeMessage(String message, String cid, String uid) {
    firestore
        .collection("conversations")
        .doc(cid)
        .collection('messages')
        .add({
          'msg': message,
          'user': uid,
          'date': DateTime.now().millisecondsSinceEpoch
        })
        .then((value) => debugPrint("message Sent"))
        .catchError((e) => e);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>?> readMessage(String cid) async* {
    var res = firestore
        .collection("conversations")
        .doc(cid)
        .collection("messages")
        .orderBy('date')
        .snapshots();
    QuerySnapshot<Map<String, dynamic>>? a;
    res.map((event) {
      a = event;
    });

    yield a;
  }

  Future<void> initUserProfile(User user) async {
    firestore
        .collection("users")
        .doc(user.uid)
        .set({'uid': user.uid, 'date_joined': DateTime.now()})
        .then((value) => debugPrint("user Added"))
        .catchError((e) => e);
  }
}
