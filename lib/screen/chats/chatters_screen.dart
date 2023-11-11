import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/providers/chat_provider.dart';
import 'package:gymbuddy/screen/chats/chat_conversation_tile.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';

class ChattersScreen extends ConsumerWidget {
  const ChattersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(chatPartnersProvider);

    if (!data.hasValue || data.value!.length == 0) {
      return const NoContentText(
        title: "Nothing here yet...",
        details: "Your chat history will appear here 💬",
      );
    }

    final List<ChatPerson> chatters = data.value!
        .map(
          (entry) => ChatPerson(
            personId: entry.id,
            personData: UserDto.fromMap(
              entry.data(),
            ),
          ),
        )
        .toList();

    return Scaffold(
        appBar: EasySearchBar(
          title: const Text('My buddies'),
          onSearch: (p0) {},
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chatters.length,
            itemBuilder: (context, index) {
              final String _userId = chatters[index].personId;
              final UserDto _user = chatters[index].personData!;

              return ChatConversationTile(
                receiverId: _userId,
                user: _user,
              );
            },
          ),
        ));
  }
}
