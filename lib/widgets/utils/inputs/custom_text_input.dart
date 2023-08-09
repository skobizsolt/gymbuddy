import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.labelText,
    required this.icon,
    this.height,
    this.color,
  });

  final String labelText;
  final IconData icon;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Card(
        color: color ?? Theme.of(context).colorScheme.background,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: labelText,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              border: InputBorder.none,
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
