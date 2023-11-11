import 'package:gymbuddy/models/chats/chat_message.dart';
import 'package:gymbuddy/models/user_dto.dart';

class ChatPerson {
  String personId;
  UserDto? personData;
  ChatMessage? lastMessage;
  ChatPerson({
    required this.personId,
    this.personData,
    this.lastMessage,
  });

  ChatPerson copyWith({
    String? personId,
    UserDto? personData,
    ChatMessage? lastMessage,
  }) {
    return ChatPerson(
      personId: personId ?? this.personId,
      personData: personData ?? this.personData,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personId': personId,
      'personData': personData?.toMap(),
      'lastMessage': lastMessage?.toMap(),
    };
  }

  @override
  String toString() =>
      'ChatPerson(personId: $personId, personData: $personData, lastMessage: $lastMessage)';

  @override
  bool operator ==(covariant ChatPerson other) {
    if (identical(this, other)) return true;

    return other.personId == personId &&
        other.personData == personData &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode =>
      personId.hashCode ^ personData.hashCode ^ lastMessage.hashCode;
}
