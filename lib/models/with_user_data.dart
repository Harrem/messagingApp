// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WithUserData {
  String uid;
  String fullName;
  bool isActive;
  String profileUrl;
  int lastSeenAt;
  WithUserData({
    required this.uid,
    required this.fullName,
    required this.isActive,
    required this.profileUrl,
    required this.lastSeenAt,
  });

  WithUserData copyWith({
    String? uid,
    String? fullName,
    bool? isActive,
    String? profileUrl,
    int? lastSeenAt,
  }) {
    return WithUserData(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      isActive: isActive ?? this.isActive,
      profileUrl: profileUrl ?? this.profileUrl,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'isActive': isActive,
      'profileUrl': profileUrl,
      'lastSeenAt': lastSeenAt,
    };
  }

  factory WithUserData.fromMap(Map<String, dynamic> map) {
    return WithUserData(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      isActive: map['isActive'] as bool,
      profileUrl: map['profileUrl'] as String,
      lastSeenAt: map['lastSeenAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithUserData.fromJson(String source) =>
      WithUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WithUserData(uid: $uid, fullName: $fullName, isActive: $isActive, profileUrl: $profileUrl, lastSeenAt: $lastSeenAt)';
  }

  @override
  bool operator ==(covariant WithUserData other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullName == fullName &&
        other.isActive == isActive &&
        other.profileUrl == profileUrl &&
        other.lastSeenAt == lastSeenAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        isActive.hashCode ^
        profileUrl.hashCode ^
        lastSeenAt.hashCode;
  }
}
