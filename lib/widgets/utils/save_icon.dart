import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSaving;

  const SaveButton({
    super.key,
    this.onPressed,
    required this.isSaving,
  });

  @override
  Widget build(BuildContext context) {
    return isSaving
        ? const SizedBox()
        : FloatingActionButton.extended(
            onPressed: onPressed,
            icon: const Icon(
              Icons.save,
            ),
            backgroundColor: Theme.of(context).primaryColorDark,
            label: const Text("Save"),
          );
  }
}
