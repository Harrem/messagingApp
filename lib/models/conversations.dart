// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'message.dart';

class Conversation {
  String? conversationId;
  String? createdDate;
  List<Message>? messages;

  Conversation({
    this.conversationId,
    this.createdDate,
    this.messages,
  });

  Conversation copyWith({
    String? conversationId,
    String? createdDate,
    List<Message>? messages,
  }) {
    return Conversation(
      conversationId: conversationId ?? this.conversationId,
      createdDate: createdDate ?? this.createdDate,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversationId': conversationId,
      'createdDate': createdDate,
      'messages': messages!.map((x) => x.toMap()).toList(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      conversationId: map['conversationId'] != null
          ? map['conversationId'] as String
          : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      messages: map['messages'] != null
          ? List<Message>.from(
              (map['messages'] as List<int>).map<Message?>(
                (x) => Message.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Conversation(conversationId: $conversationId, createdDate: $createdDate, messages: $messages)';

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.conversationId == conversationId &&
        other.createdDate == createdDate &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode =>
      conversationId.hashCode ^ createdDate.hashCode ^ messages.hashCode;
}
