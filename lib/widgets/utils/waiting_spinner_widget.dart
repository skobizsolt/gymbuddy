import 'package:flutter/material.dart';

class WaitingSpinner extends StatelessWidget {
  final String title;
  final Color? color;
  const WaitingSpinner({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          title,
          style: const TextStyle().copyWith(color: color),
        ),
      ],
    );
  }
}
