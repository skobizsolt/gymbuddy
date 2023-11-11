import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/chats/chat_message.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';
import 'package:gymbuddy/models/user_dto.dart';

class ChatHistoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User _currentUser = FirebaseAuth.instance.currentUser!;

  Future<List<Future<ChatPerson>>> getHistory() async {
    return await _firestore
        .collection(FIRESTORE_CHATS_COLLECTION)
        .get()
        .then((event) async => await event.docs
                .where(
                  (element) => List<String>.from(element.data()['users'])
                      .contains(_currentUser.uid),
                )
                .toList()
                .map((element) async {
              List<String> ids =
                  element.id.split(FIRESTORE_CHATROOM_ID_DELIMITER);
              final String personId =
                  ids.firstWhere((id) => id != _currentUser.uid);
              final person = ChatPerson(
                personId: personId,
              );
              await _getPersonData(personId)
                  .then((value) => person.personData = value);
              await _getLastMessage(element.id)
                  .then((value) => person.lastMessage = value);
              return person;
            }).toList());
  }

  getMessageSnapshots() {
    return _firestore.collection(FIRESTORE_CHATS_COLLECTION).snapshots();
  }

  Future<UserDto> _getPersonData(String personId) async {
    return await _firestore
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(personId)
        .get()
        .then((value) => UserDto.fromMap(value.data()!));
  }

  Future<ChatMessage> _getLastMessage(String chatRoomId) async {
    return await _firestore
        .collection(FIRESTORE_CHATS_COLLECTION)
        .doc(chatRoomId)
        .collection(FIRESTORE_CHATS_MESSAGES_SUBCOLLECTION)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((value) => ChatMessage.fromMap(value.docs.first.data()));
  }
}
