import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/models/chats/chat_message.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/widgets/chats/message_bubble.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ChatBuilder extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final String senderId;
  final UserDto receiverData;

  const ChatBuilder({
    super.key,
    required this.stream,
    required this.senderId,
    required this.receiverData,
  });

  Widget renderNewChatDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          receiverData.profileImageUrl == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ProfilePicture(
                    picture: NetworkImage(receiverData.profileImageUrl!),
                    size: 75,
                  ),
                ),
          Text(
            "Start a new chat with",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            "⭐ ${receiverData.firstName} ${receiverData.lastName} ⭐",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text('Username: ${receiverData.username}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        var snapshotsData = snapshot.data;
        if (snapshotsData == null || snapshotsData.docs.isEmpty) {
          return renderNewChatDisplay(context);
        }

        var messages = snapshotsData.docs
            .map(
              (e) => Message.fromMap(e.data()),
            )
            .toList();

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 12),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var currentMessage = messages[index];
            final isMineMessage = currentMessage.senderId == senderId;
            if (isMineMessage) {
              return MessageBubble.myMessage(message: currentMessage.message);
            }

            final nextMessage =
                index + 1 < messages.length ? messages[index + 1] : null;
            final isNextMessageTheSame = nextMessage != null &&
                currentMessage.senderId == nextMessage.senderId;
            if (isNextMessageTheSame) {
              return MessageBubble.next(message: currentMessage.message);
            }
            return MessageBubble.first(
              userImage: receiverData.profileImageUrl,
              username: receiverData.username,
              message: currentMessage.message,
            );
          },
        );
      },
    );
  }
}
