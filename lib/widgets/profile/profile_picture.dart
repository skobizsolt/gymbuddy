import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, this.profilePicture, this.size});

  final ImageProvider<Object>? profilePicture;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 75,
      width: size ?? 75,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: profilePicture ?? MemoryImage(kTransparentImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
