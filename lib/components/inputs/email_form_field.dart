import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/service/auth/validators.dart';

class EmailFormField extends StatelessWidget {
  final Function(String?)? onSaved;
  const EmailFormField({super.key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return InputLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration.collapsed(
            hintText: 'Email',
          ),
          validator: (value) {
            return InputValidator().validateEmail(value);
          },
          onSaved: onSaved,
        ),
      ),
    );
  }
}
