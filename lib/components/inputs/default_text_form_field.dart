import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/service/validators.dart';

class DefaultTextFormField extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.initialValue,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return InputLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration.collapsed(
            hintText: hintText,
          ),
          validator: validator ??
              (value) {
                return InputValidator().validateBasicText(value, hintText);
              },
          onSaved: onSaved,
          initialValue: initialValue ?? null,
        ),
      ),
    );
  }
}
