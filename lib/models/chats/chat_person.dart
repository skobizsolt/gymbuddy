import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymbuddy/models/chats/chat_message.dart';
import 'package:gymbuddy/models/user_dto.dart';

class ChatPerson {
  String personId;
  UserDto? personData;
  ChatMessage? lastMessage;
  Timestamp? lastActive;
  ChatPerson({
    required this.personId,
    this.personData,
    this.lastMessage,
    this.lastActive,
  });

  ChatPerson copyWith({
    String? personId,
    UserDto? personData,
    ChatMessage? lastMessage,
    Timestamp? lastActive,
  }) {
    return ChatPerson(
      personId: personId ?? this.personId,
      personData: personData ?? this.personData,
      lastMessage: lastMessage ?? this.lastMessage,
      lastActive: lastActive ?? this.lastActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personId': personId,
      'personData': personData?.toMap(),
      'lastMessage': lastMessage?.toMap(),
      'lastActive': lastActive,
    };
  }

  @override
  String toString() {
    return 'ChatPerson(personId: $personId, personData: $personData, lastMessage: $lastMessage, lastActive: $lastActive)';
  }

  @override
  bool operator ==(covariant ChatPerson other) {
    if (identical(this, other)) return true;

    return other.personId == personId &&
        other.personData == personData &&
        other.lastMessage == lastMessage &&
        other.lastActive == lastActive;
  }

  @override
  int get hashCode {
    return personId.hashCode ^
        personData.hashCode ^
        lastMessage.hashCode ^
        lastActive.hashCode;
  }
}
