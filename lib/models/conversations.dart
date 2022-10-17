// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'message.dart';

class Conversation {
  String conversationId;
  DateTime createdDate;
  List<Message> messages;
  String docRef;

  Conversation({
    required this.conversationId,
    required this.createdDate,
    required this.messages,
    required this.docRef,
  });

  Conversation copyWith({
    String? conversationId,
    DateTime? createdDate,
    List<Message>? messages,
    String? docRef,
  }) {
    return Conversation(
      conversationId: conversationId ?? this.conversationId,
      createdDate: createdDate ?? this.createdDate,
      messages: messages ?? this.messages,
      docRef: docRef ?? this.docRef,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversationId': conversationId,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'messages': messages.map((x) => x.toMap()).toList(),
      'docRef': docRef,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      conversationId: map['conversationId'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      messages: List<Message>.from(
        (map['messages'] as List<dynamic>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      docRef: map['docRef'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, createdDate: $createdDate, messages: $messages, docRef: $docRef)';
  }

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.conversationId == conversationId &&
        other.createdDate == createdDate &&
        listEquals(other.messages, messages) &&
        other.docRef == docRef;
  }

  @override
  int get hashCode {
    return conversationId.hashCode ^
        createdDate.hashCode ^
        messages.hashCode ^
        docRef.hashCode;
  }
}
