import 'package:flutter/material.dart';
import 'package:gymbuddy/service/auth/logout_service.dart';
import 'package:gymbuddy/widgets/profile/option_card.dart';
import 'package:gymbuddy/widgets/profile/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        // Saved workouts
        OptionCard(
          title: 'Saved Workouts',
          icon: Icons.favorite_outline_rounded,
        ),

        // Change password
        OptionCard(
          title: 'Change password',
          icon: Icons.lock_outline_rounded,
        ),

        //Log out
        OptionCard(
          title: 'Logout',
          icon: Icons.logout,
          onTap: signOut,
        ),
      ],
    );
  }
}
