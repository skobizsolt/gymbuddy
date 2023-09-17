// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/providers/chat_provider.dart';
import 'package:gymbuddy/screen/chats/chat_conversation_screen.dart';
import 'package:gymbuddy/components/inputs/custom_searchbar.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ChatsScreen extends ConsumerWidget {
  ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(chatsProvider);

    if (!data.hasValue || data.value!.length == 0) {
      return const NoContentText(
        title: "Nothing here yet...",
        details: "Your chat history will appear here 💬",
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                      height: 50,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_add_alt_1,
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // chats
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.value!.length,
              itemBuilder: (context, index) {
                final String _userId = data.value![index].id;
                final UserDto _user =
                    UserDto.fromMap(data.value![index].data());

                final url = _user.profileImageUrl;

                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).primaryColorLight))),
                  child: ListTile(
                    visualDensity: const VisualDensity(
                      vertical: VisualDensity.maximumDensity,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfilePicture(
                        picture: url == null
                            ? null
                            : NetworkImage(
                                url,
                              ),
                        child: url == null ? const Icon(Icons.person) : null,
                        size: 32,
                      ),
                    ),
                    title: Text(
                      '${_user.firstName} ' +
                          '${_user.lastName} ' +
                          '(${_user.username})',
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConversationScreen(
                            receiverId: _userId,
                            receiverData: _user,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
