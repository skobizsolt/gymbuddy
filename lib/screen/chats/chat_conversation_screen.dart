import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/chat_builder.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/providers/user_provider.dart';
import 'package:gymbuddy/service/chats/chat_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  ConversationScreen({
    super.key,
    required this.receiverId,
    required this.receiverData,
  });

  final String receiverId;
  final UserDto receiverData;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final _chatController = TextEditingController();

  final _chatService = ChatService();

  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  void setupPushNotifications() async {
    final firebaseMessagging = FirebaseMessaging.instance;
    await firebaseMessagging.requestPermission();

    firebaseMessagging.subscribeToTopic(FIREBASE_NOTIFICATION_CHATS_TOPIC);
  }

  void sendMessage(UserDto sender) async {
    if (_chatController.text.isNotEmpty) {
      await _chatService.sendMessage(
        "${sender.firstName} ${sender.lastName}",
        widget.receiverId,
        _chatController.text,
      );
    }
  }

  Widget _renderAvatar() {
    if (widget.receiverData.profileImageUrl == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        ProfilePicture(
          picture: NetworkImage(widget.receiverData.profileImageUrl!),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userData = ref.watch(userProvider).value;
    return GestureDetector(
      onTap: () => KeyboardService().unFocusKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          titleSpacing: 0,
          title: Row(
            children: [
              _renderAvatar(),
              Flexible(
                child: Text(
                    "${widget.receiverData.firstName} ${widget.receiverData.lastName}"),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 8),
          child: _buildMessages(),
        ),
        bottomSheet: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: InputLayout(
                  height: 50,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  child: TextFormField(
                    controller: _chatController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Say something...',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                onPressed: () {
                  if (_userData == null) {
                    showErrorSnackBar(context,
                        "Something went wrong, please try again later!");
                  } else {
                    sendMessage(_userData);
                  }
                  _chatController.clear();
                  KeyboardService().closeKeyboard();
                },
                icon: const Icon(
                  Icons.send,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildMessages() {
    final data = _chatService.getMessages(_currentUser!.uid, widget.receiverId);
    return ChatBuilder(
      senderId: _currentUser!.uid,
      receiverData: widget.receiverData,
      stream: data,
    );
  }
}
