import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/service/validators.dart';

class PasswordFormField extends StatelessWidget {
  final String hintText;
  final Function(String?)? onsaved;
  const PasswordFormField({
    super.key,
    required this.hintText,
    required this.onsaved,
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
          obscureText: true,
          validator: (value) {
            return InputValidator().validatePassword(value);
          },
          onSaved: onsaved,
        ),
      ),
    );
  }
}
