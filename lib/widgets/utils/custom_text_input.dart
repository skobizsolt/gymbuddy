import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.labelText,
    required this.icon,
  });

  final String labelText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ],
        ),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          labelText: labelText,
          border: InputBorder.none,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
