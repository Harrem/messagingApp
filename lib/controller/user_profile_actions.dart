import 'dart:io';
import 'package:assignment/models/conversations.dart';
import 'package:assignment/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UserActions extends ChangeNotifier {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late DocumentReference userDoc;
  UserData userData = UserData(firstName: '', lastName: '');

  UserActions() {
    userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
  }

  Future<UserData> getUserData() async {
    final data = await userDoc
        .get()
        .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
    userData = UserData.fromMap(data);
    debugPrint("Fetched User Data");
    return userData;
  }

  Future<void> createProfile({
    required String firstName,
    required String lastName,
    String? birthDate,
    String? gender,
  }) async {
    userData.uid = uid;
    userData.email = FirebaseAuth.instance.currentUser!.email;
    userData.firstName = firstName;
    userData.lastName = lastName;
    userData.birthDate = birthDate;
    userData.gender = gender;
    userData.joinedDate = DateTime.now().toIso8601String();
    userData.conversations = [];
    await syncUserData();
  }

//TODO: imlement profile uploading to firebase storage
  Future<void> updateProfilePicture(File profilePic) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final storageRef = firebaseStorage.ref();
    final userProfileRef = storageRef.child('$uid/proPic.jpg');
    userProfileRef.putFile(profilePic);
    userData.profilePictureUrl = await userProfileRef.getDownloadURL();
    await syncUserData();
  }

  Future<List<Map<String, dynamic>?>> search(String text) async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    final docs = users.docs;
    List<Map<String, dynamic>> list = [];
    for (var e in docs) {
      String str =
          "${e.data()['firstName'].toString().toLowerCase()} ${e.data()['lastName'].toString().toLowerCase()}";
      if (str.contains(text.toLowerCase())) {
        debugPrint(str);
        list.add(e.data());
      }
    }
    debugPrint(list.length.toString());
    // final matchedUsers = users.docs.map((e) {
    //   final name = e.data()['firstName'];
    //   if (text.isEmpty) {
    //     return e.data();
    //   } else if (name.toString().trim().toLowerCase() ==
    //       text.trim().toLowerCase()) {
    //     return e.data();
    //   }
    //   return e.data();
    // }).toList();
    if (list.isEmpty) {
      return [];
    }
    return list;
  }

  Future<void> syncUserData() async {
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .doc(uid)
        .set(userData.toMap())
        .then((value) => debugPrint("User Data synced"));
  }
}
