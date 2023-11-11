import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/chats/chat_message.dart';

class ChatService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User _currentUser = FirebaseAuth.instance.currentUser!;

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsers() {
    return _firestore.collection(FIRESTORE_USER_COLLECTION).snapshots().map(
          (event) => event.docs
              .where((element) => element.id != _currentUser.uid)
              .toList(),
        );
  }

  // Send message
  Future<void> sendMessage(
      String senderName, String reveiverId, String message) async {
    // Create new message
    final ChatMessage chatMessage = ChatMessage(
        senderId: _currentUser.uid,
        senderName: senderName,
        receiverId: reveiverId,
        message: message,
        timestamp: Timestamp.now());

    // construct chat room id
    List<String> chatroomIds = [_currentUser.uid, reveiverId];
    chatroomIds.sort();
    String chatRoomName = chatroomIds.join(FIRESTORE_CHATROOM_ID_DELIMITER);

    final docRef = _getChatRoomRef(chatRoomName);

    // if document not found, create room
    await docRef.get().then((value) {
      if (!value.exists) {
        docRef.set({'users': chatroomIds});
      }
      return value;
    });

    // add new message to database
    docRef
        .collection(FIRESTORE_CHATS_MESSAGES_SUBCOLLECTION)
        .add(chatMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String userId, String receiverId) {
    List<String> chatroomIds = [userId, receiverId];
    chatroomIds.sort();
    String chatRoomName = chatroomIds.join(FIRESTORE_CHATROOM_ID_DELIMITER);

    return _getChatRoomRef(chatRoomName)
        .collection(FIRESTORE_CHATS_MESSAGES_SUBCOLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  DocumentReference<Map<String, dynamic>> _getChatRoomRef(
    final String chatRoomName,
  ) {
    return _firestore.collection(FIRESTORE_CHATS_COLLECTION).doc(chatRoomName);
  }
}
