import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile screen',
        style: TextStyle(
            fontSize: 48, color: Theme.of(context).textTheme.titleLarge!.color),
      ),
    );
  }
}
