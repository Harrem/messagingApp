// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String text;
  DateTime sentDate;
  bool read;
  Message({
    required this.text,
    required this.sentDate,
    required this.read,
  });

  Message copyWith({
    String? text,
    DateTime? sentDate,
    bool? read,
  }) {
    return Message(
      text: text ?? this.text,
      sentDate: sentDate ?? this.sentDate,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'sentDate': sentDate.millisecondsSinceEpoch,
      'read': read,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] as String,
      sentDate: DateTime.fromMillisecondsSinceEpoch(map['sentDate'] as int),
      read: map['read'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(text: $text, sentDate: $sentDate, read: $read)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.sentDate == sentDate &&
        other.read == read;
  }

  @override
  int get hashCode => text.hashCode ^ sentDate.hashCode ^ read.hashCode;
}
