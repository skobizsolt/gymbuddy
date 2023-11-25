import 'package:flutter/material.dart';

void showErrorSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.onError);
}

void showSuccessSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: Colors.greenAccent[200], textColor: Colors.green[800]);
}

void _showSnackbar(final BuildContext context, final String message,
    {Color? backgroundColor, Color? textColor}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle()
            .copyWith(fontStyle: FontStyle.italic, color: textColor),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
