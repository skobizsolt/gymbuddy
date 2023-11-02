import 'dart:io';

import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final File image;
  const CarouselImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Image.file(
            width: double.infinity,
            fit: BoxFit.cover,
            File(image.path),
          ),
        ));
  }
}
