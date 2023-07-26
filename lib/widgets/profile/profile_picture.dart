import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () {},
        child: const Icon(
          Icons.person_rounded,
          size: 75,
        ),
      ),
    );
  }
}
