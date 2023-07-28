import 'package:flutter/material.dart';

class OptionText extends StatelessWidget {
  const OptionText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
