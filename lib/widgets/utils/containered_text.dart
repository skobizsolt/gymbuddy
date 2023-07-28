import 'package:flutter/material.dart';

class ContaineredText extends StatelessWidget {
  const ContaineredText({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        text,
        style: style ?? const TextStyle(),
      ),
    );
  }
}
