import 'package:flutter/material.dart';

class BigElevatedIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final String text;
  const BigElevatedIconButton(
      {super.key, required this.icon, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
            icon: icon,
            onPressed: onPressed,
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )),
      ),
    );
  }
}
