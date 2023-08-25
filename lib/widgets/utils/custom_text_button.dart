import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.onPressed, required this.text, this.textStyle});

  final String text;
  final Function() onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: const ButtonStyle().copyWith(
        textStyle: MaterialStatePropertyAll(
            textStyle ?? Theme.of(context).textTheme.titleMedium!),
      ),
    );
  }
}
