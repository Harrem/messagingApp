import 'dart:io';
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

  Future<void> getUserData() async {
    final data = await userDoc
        .get()
        .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
    userData = UserData.fromMap(data);
    debugPrint("Fetched User Data");
  }

  Future<void> createProfile({
    required String firstName,
    required String lastName,
    String? birthDate,
    String? gender,
  }) async {
    userData.firstName = firstName;
    userData.lastName = lastName;
    userData.birthDate = birthDate;
    userData.gender = gender;
    userData.joinedDate = DateTime.now().toIso8601String();
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

  Future<List<Map<String, dynamic>>> search(String text) async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    final matchedUsers = users.docs.map((e) {
      final name = e.data()['firstName'];
      if (text.isEmpty) {
        return e.data();
      } else if (name.toString().trim().toLowerCase() ==
          text.trim().toLowerCase()) {
        debugPrint("user found!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        return e.data();
      }
      return e.data();
    }).toList();
    return matchedUsers;
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
