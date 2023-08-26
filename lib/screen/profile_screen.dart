import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/user_provider.dart';
import 'package:gymbuddy/screen/profile/change_password_screen.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/widgets/profile/option_card.dart';
import 'package:gymbuddy/widgets/profile/profile_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
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
            onTap: () => AuthService().signOut(context),
          ),
        ],
      ),
    );
  }
}
