// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:assignment/models/conversations.dart';

class UserData {
  String uid;
  String email;
  String firstName;
  String lastName;
  String birthDate;
  DateTime joinedDate;
  String gender;
  String profilePictureUrl;
  bool isActive;
  List<Conversation> conversations;
  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.joinedDate,
    required this.gender,
    required this.profilePictureUrl,
    required this.isActive,
    required this.conversations,
  });

  UserData copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? birthDate,
    DateTime? joinedDate,
    String? gender,
    String? profilePictureUrl,
    bool? isActive,
    List<Conversation>? conversations,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      joinedDate: joinedDate ?? this.joinedDate,
      gender: gender ?? this.gender,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isActive: isActive ?? this.isActive,
      conversations: conversations ?? this.conversations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'joinedDate': joinedDate.millisecondsSinceEpoch,
      'gender': gender,
      'profilePictureUrl': profilePictureUrl,
      'isActive': isActive,
      'conversations': conversations.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      birthDate: map['birthDate'] as String,
      joinedDate: DateTime.fromMillisecondsSinceEpoch(map['joinedDate'] as int),
      gender: map['gender'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      isActive: map['isActive'] as bool,
      conversations: List<Conversation>.from(
        (map['conversations'] as List<dynamic>).map<Conversation>(
          (x) => Conversation.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, joinedDate: $joinedDate, gender: $gender, profilePictureUrl: $profilePictureUrl, isActive: $isActive, conversations: $conversations)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.birthDate == birthDate &&
        other.joinedDate == joinedDate &&
        other.gender == gender &&
        other.profilePictureUrl == profilePictureUrl &&
        other.isActive == isActive &&
        listEquals(other.conversations, conversations);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        birthDate.hashCode ^
        joinedDate.hashCode ^
        gender.hashCode ^
        profilePictureUrl.hashCode ^
        isActive.hashCode ^
        conversations.hashCode;
  }
}
