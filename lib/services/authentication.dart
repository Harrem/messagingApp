import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      {required email, required password}) async {
    User? user;
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error("User Not Found");
      } else if (e.code == "wrong-password") {
        return Future.error("Invalid Password");
      } else if (e.code == "invalid-email") {
        return Future.error("Invalid Email Address");
      } else {
        return Future.error(e.message.toString());
      }
    } on SocketException catch (e) {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }

    return user;
  }

  Future<void> signout() async {
    await firebaseAuth.signOut();
    debugPrint("Signed out successfully");
  }
}
