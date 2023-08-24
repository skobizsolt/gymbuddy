import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/service/auth/validators.dart';

class UsernameFormField extends StatelessWidget {
  final Function(String?)? onSaved;

  const UsernameFormField({super.key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return InputLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          autocorrect: false,
          decoration: InputDecoration.collapsed(
            hintText: 'Username',
          ),
          validator: (value) {
            return InputValidator().validateUsername(value);
          },
          onSaved: onSaved,
        ),
      ),
    );
  }
}
