import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';

class CustomTextInput extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final IconData? icon;
  final double? height;
  final Color? color;
  final bool? obscureText;

  CustomTextInput({
    super.key,
    this.controller,
    required this.labelText,
    this.icon,
    this.height,
    this.color,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return InputLayout(
      color: color,
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
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
