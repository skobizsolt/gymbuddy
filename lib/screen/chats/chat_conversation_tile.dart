import 'package:flutter/material.dart';
import 'package:gymbuddy/models/chats/chat_message.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/screen/chats/chat_conversation_screen.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ChatConversationTile extends StatelessWidget {
  final String receiverId;
  final UserDto user;
  final ChatMessage? lastMessage;
  const ChatConversationTile({
    super.key,
    required this.receiverId,
    required this.user,
    this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
      ),
      child: ListTile(
        visualDensity: const VisualDensity(
          vertical: VisualDensity.maximumDensity,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfilePicture(
            picture: user.profileImageUrl == null
                ? null
                : NetworkImage(
                    user.profileImageUrl!,
                  ),
            child:
                user.profileImageUrl == null ? const Icon(Icons.person) : null,
            size: 32,
          ),
        ),
        title: Text(
          '${user.firstName} ' + '${user.lastName} ' + '(${user.username})',
        ),
        subtitle: _buildSubtitle(context),
        trailing: _buildTrailing(context),
        horizontalTitleGap: 4,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConversationScreen(
                receiverId: receiverId,
                receiverData: user,
              ),
            ),
          );
        },
      ),
    );
  }

  _buildSubtitle(final BuildContext context) {
    return lastMessage == null
        ? null
        : Text(
            '${isMessageFromReceiver ? user.firstName : 'You'}: ${lastMessage!.message}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: isMessageFromReceiver ? FontWeight.w800 : null,
                ),
          );
  }

  get isMessageFromReceiver {
    return lastMessage!.senderId == receiverId;
  }

  _buildTrailing(BuildContext context) {
    return lastMessage != null && isMessageFromReceiver
        ? const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.circle,
              size: 16,
            ),
          )
        : null;
  }
}
