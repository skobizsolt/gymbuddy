import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chats screen',
        style: TextStyle(
            fontSize: 48, color: Theme.of(context).textTheme.titleLarge!.color),
      ),
    );
  }
}
