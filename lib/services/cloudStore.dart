import 'package:assignment/models/with_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class CloudStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void writeMessage(String message, String cid, String uid) {
    var msg = Message(
        text: message,
        sentDate: DateTime.now(),
        cid: cid,
        fromUid: uid,
        isDelivered: false,
        didRead: false);

    firestore
        .collection("conversations")
        .doc(cid)
        .collection('messages')
        .add(msg.toMap())
        .then((value) => debugPrint("message Sent"))
        .catchError((e) => e);
  }

  Stream<List<Message>?> readMessage(String cid) {
    return firestore
        .collection("conversations")
        .doc(cid)
        .collection("messages")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        debugPrint("sdkfjlsdjfs");
        return Message.fromMap(e.data());
      }).toList();
    });
  }

  Future<void> initUserProfile(User user) async {
    firestore
        .collection("users")
        .doc(user.uid)
        .set({'uid': user.uid, 'date_joined': DateTime.now()})
        .then((value) => debugPrint("user Added"))
        .catchError((e) => e);
  }

  Future<WithUserData> getWithUser(String wuid) async {
    var doc = await firestore.collection('users').doc(wuid).get();
    var wu = WithUserData.fromMap(doc.data()!);
    return wu;
  }
}
