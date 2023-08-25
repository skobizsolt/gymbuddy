import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {
  const BrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/images/logo.png',
      cacheHeight: 144,
    );
  }
}
