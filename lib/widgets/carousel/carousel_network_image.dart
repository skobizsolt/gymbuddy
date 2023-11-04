import 'package:flutter/material.dart';

class CarouselNetworkImage extends StatelessWidget {
  final String url;
  const CarouselNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Image.network(
              width: double.infinity,
              fit: BoxFit.cover,
              url,
            ),
          )),
    );
  }
}
