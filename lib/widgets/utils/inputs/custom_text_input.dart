import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      required this.labelText,
      this.icon,
      this.height,
      this.color,
      this.isObscured});

  final String labelText;
  final IconData? icon;
  final double? height;
  final Color? color;
  final bool? isObscured;

  @override
  Widget build(BuildContext context) {
    return InputLayout(
      color: color,
      child: TextField(
        obscureText: isObscured ?? false,
        decoration: InputDecoration(
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
          hintText: labelText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          border: InputBorder.none,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
