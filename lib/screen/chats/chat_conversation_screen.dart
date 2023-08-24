import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';
import 'package:transparent_image/transparent_image.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen(
      {super.key, required this.receiverName, required this.receiverAvatar});

  final String receiverName;
  final Object receiverAvatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        titleSpacing: 0,
        title: Row(
          children: [
            ProfilePicture(
                picture: receiverAvatar,
                child: receiverAvatar == MemoryImage(kTransparentImage)
                    ? const Icon(Icons.person)
                    : const SizedBox()),
            const SizedBox(
              width: 5,
            ),
            Text(receiverName),
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
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: InputLayout(
                height: 40,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                child: TextFormField(
                  decoration: InputDecoration().copyWith(
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
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(
                Icons.send,
              ),
            )
          ],
        ),
      ),
    );
  }
}
