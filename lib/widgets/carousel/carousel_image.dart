import 'dart:io';

import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final File file;
  const CarouselImage({super.key, required this.file});

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
            File(file.path),
          ),
        ));
  }
}
