import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';
import 'package:gymbuddy/providers/chat_provider.dart';
import 'package:gymbuddy/screen/chats/chat_conversation_tile.dart';
import 'package:gymbuddy/screen/chats/chatters_screen.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';

class ChatHistoryScreen extends ConsumerWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(chatHistoryProvider);

    final List<Future<ChatPerson>> chatters =
        data.value == null ? List<Future<ChatPerson>>.from([]) : data.value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My buddies'),
        actions: [
          IconButton(
            onPressed: () => _openChattersScreen(context),
            icon: const Icon(Icons.people),
          ),
        ],
      ),
      body: _renderContent(context, chatters),
    );
  }

  _openChattersScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChattersScreen(),
    ));
  }

  _renderContent(BuildContext context, List<Future<ChatPerson>> chatters) {
    if (chatters.isEmpty) {
      return const NoContentText(
        title: "Nothing here yet...",
        details: "Your chat history will appear here 💬",
      );
    }
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: chatters.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: chatters[index],
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.personData == null) {
                return const SizedBox();
              }

              final receiver = snapshot.data!;

              return ChatConversationTile(
                receiverId: receiver.personId,
                user: receiver.personData!,
                lastMessage: receiver.lastMessage,
              );
            },
          );
        },
      ),
    );
  }
}
