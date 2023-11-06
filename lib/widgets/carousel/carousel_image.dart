import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final Widget image;
  const CarouselImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: image,
          ),
        ));
  }
}
