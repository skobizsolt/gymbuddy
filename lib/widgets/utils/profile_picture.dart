import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, this.picture, this.size, this.child});

  final Object? picture;
  final double? size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.transparent,
      backgroundImage: picture == null
          ? MemoryImage(kTransparentImage)
          : picture as ImageProvider<Object>,
      child: child,
    );
  }
}
