import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/profile/option_card.dart';
import 'package:gymbuddy/widgets/profile/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var options = [
      {
        'title': 'Saved Workouts',
        'icon': Icons.favorite_outline_rounded,
      },
      {
        'title': 'Change password',
        'icon': Icons.lock_outline_rounded,
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
      }
    ];

    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        const ProfileCard(),
        const SizedBox(
          height: 75,
        ),
        // render each option
        ...options.map(
          (option) => OptionCard(
              title: option['title'] as String,
              icon: option['icon'] as IconData),
        ),
      ],
    );
  }
}
