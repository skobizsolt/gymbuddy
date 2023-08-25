import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.color,
  });

  final String text;
  final IconData? icon;
  final Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Widget buildText() {
      var textWidget = Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      );

      if (icon != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              width: 5,
            ),
            textWidget
          ],
        );
      }
      return textWidget;
    }

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          color: color ?? Theme.of(context).primaryColorDark,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: buildText(),
            ),
          ),
        ),
      ),
    );
  }
}
