import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/screen/profile/change_password_screen.dart';
import 'package:gymbuddy/widgets/profile/option_card.dart';
import 'package:gymbuddy/widgets/profile/profile_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
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
          const OptionCard(
            title: 'Saved Workouts',
            icon: Icons.favorite_outline_rounded,
          ),

          // Change password
          OptionCard(
            title: 'Change password',
            icon: Icons.lock_outline_rounded,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            ),
          ),

          //Log out
          OptionCard(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () => ref.read(authProvider.notifier).signOut(context),
          ),
        ],
      ),
    );
  }
}
