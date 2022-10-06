// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserData {
  String firstName;
  String lastName;
  String? birthDate;
  String? joinedDate;
  String? gender;
  String? profilePictureUrl;
  bool? isActive;
  List<String>? conversations;
  UserData({
    required this.firstName,
    required this.lastName,
    this.birthDate,
    this.joinedDate,
    this.gender,
    this.profilePictureUrl,
    this.isActive,
    this.conversations,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? birthDate,
    String? joinedDate,
    String? gender,
    String? profilePictureUrl,
    bool? isActive,
    List<String>? conversations,
  }) {
    return UserData(
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
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'joinedDate': joinedDate,
      'gender': gender,
      'profilePictureUrl': profilePictureUrl,
      'isActive': isActive,
      'conversations': conversations,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      birthDate: map['birthDate'] != null ? map['birthDate'] as String : null,
      joinedDate:
          map['joinedDate'] != null ? map['joinedDate'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      profilePictureUrl: map['profilePictureUrl'] != null
          ? map['profilePictureUrl'] as String
          : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      conversations: map['conversations'] != null
          ? List<String>.from(map['conversations'] as List<String>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(firstName: $firstName, lastName: $lastName, birthDate: $birthDate, joinedDate: $joinedDate, gender: $gender, profilePictureUrl: $profilePictureUrl, isActive: $isActive, conversations: $conversations)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
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
    return firstName.hashCode ^
        lastName.hashCode ^
        birthDate.hashCode ^
        joinedDate.hashCode ^
        gender.hashCode ^
        profilePictureUrl.hashCode ^
        isActive.hashCode ^
        conversations.hashCode;
  }
}
