import 'dart:io';

import 'package:assignment/services/cloudStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// checks if user is signed in  or not
  bool checkUser() {
    if (firebaseAuth.currentUser != null) return true;
    return false;
  }

  ///Sign in to firebase auth
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

  ///Sign up to firebase auth
  Future<User?> signUpWithEmailAndPassword(
      {required email, required password}) async {
    User? user;
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

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
      debugPrint(e.message);
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }

    CloudStore().initUserProfile(user!);

    return user;
  }

//sign out from firebase auth
  Future<void> signout() async {
    await firebaseAuth.signOut();
    debugPrint("Signed out successfully");
  }
}
