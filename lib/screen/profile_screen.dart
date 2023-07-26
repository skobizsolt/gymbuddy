import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/profile/option_card.dart';
import 'package:gymbuddy/widgets/profile/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 25,
        ),
        ProfileCard(),
        SizedBox(
          height: 75,
        ),
        OptionCard(
          title: 'Saved Workouts',
          icon: Icons.favorite_outline_rounded,
        ),
        OptionCard(
          title: 'Change password',
          icon: Icons.lock_outline_rounded,
        ),
        OptionCard(
          title: 'Logout',
          icon: Icons.logout,
        ),
      ],
    );
  }
}
