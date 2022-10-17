import 'dart:io';
import 'package:assignment/models/conversations.dart';
import 'package:assignment/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UserActions extends ChangeNotifier {
  late DocumentReference userDoc;
  late UserData userData;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  Future<UserData> getUserData() async {
    userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
    final data = await userDoc
        .get()
        .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
    userData = UserData.fromMap(data);
    debugPrint("Fetched User Data");
    return userData;
  }

  Future<void> createProfile(UserData data) async {
    userData = data;
    await syncUserData();
  }

//TODO: imlement profile uploading to firebase storage
  Future<void> updateProfilePicture(File profilePic) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    debugPrint("Createing Storage Reference! ");
    final storageRef = firebaseStorage.ref();

    debugPrint("storageRef created! ");
    final userProfileRef = storageRef.child('${userData.uid}/proPic.jpg');

    debugPrint("uploading file");
    var task = await userProfileRef.putFile(profilePic);

    if (task.state == TaskState.success) {
      await userProfileRef.getDownloadURL().then((value) {
        userData.profilePictureUrl = value;
        notifyListeners();
        debugPrint("file uploaded");
      });
    } else if (task.state == TaskState.error) {
      return Future.error(task.state.name);
    }
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

  Future<void> createConversation(String withuserid) async {
    final firestore = FirebaseFirestore.instance;
    final docRef =
        await firestore.collection("conversations").add({'toUid': withuserid});
    DocumentReference ref = docRef;
    Conversation conv = Conversation(
      docRef: ref.path,
      conversationId: ref.id,
      createdDate: DateTime.now(),
      messages: [],
    );
    debugPrint(ref.path);
    if (userData.conversations == null) {
      userData.conversations = [conv];
    } else {
      userData.conversations.add(conv);
    }
    syncUserData();
  }

  Future<List<Conversation>?> getConversations() async {
    return userData.conversations;
  }

  Future<void> syncUserData() async {
    final firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(userData.uid).set(userData.toMap()).then(
          (value) => debugPrint("User Data synced"),
        );
  }
}
