import 'package:flutter/material.dart';

class ThemedIcon extends StatelessWidget {
  const ThemedIcon(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }
}
