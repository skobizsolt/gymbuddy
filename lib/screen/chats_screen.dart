// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/data/chat_history_data.dart';
import 'package:gymbuddy/models/chat_history.dart';
import 'package:gymbuddy/screen/chats/chat_conversation_screen.dart';
import 'package:gymbuddy/components/inputs/custom_searchbar.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:transparent_image/transparent_image.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  List<ChatHistory> get orderedHistory {
    var orderedList = List.of(chatHistoryData);
    orderedList.sort((entry, entry2) =>
        entry2.lastMessageDate.compareTo(entry.lastMessageDate));
    return orderedList;
  }

  @override
  Widget build(BuildContext context) {
    if (chatHistoryData == null) {
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
              padding: const EdgeInsets.all(8.0),
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
              itemCount: orderedHistory.length,
              itemBuilder: (context, index) {
                final url = orderedHistory[index].receiverProfilePictureUrl;

                Object picture = url == null
                    ? MemoryImage(kTransparentImage)
                    : NetworkImage(url);

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
                    leading: ProfilePicture(
                      picture: picture,
                      size: 32,
                    ),
                    title: Text(orderedHistory[index].receiverUserName),
                    subtitle: Text(orderedHistory[index].lastMessage),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConversationScreen(
                            receiverName:
                                orderedHistory[index].receiverUserName,
                            receiverAvatar: picture,
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
