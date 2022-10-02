import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserActions {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late DocumentReference userDoc;
  UserActions() {
    userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
  }
  Future<void> createProfile({
    required String firstName,
    required String lastName,
    String? birthDate,
    String? gender,
  }) async {
    await userDoc.set({
      'uid': uid,
      'firstTimeUser': false,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'dateJoined': DateTime.now().toIso8601String(),
      'gender': gender,
    }).then(
      (value) => debugPrint("Data has been written successfully!"),
    );
  }
}
