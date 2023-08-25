import 'package:flutter/material.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/service/auth/user_service.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  late String _email;

  void saveForm() {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    UserService().passwordReset(context, _email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Forgot password',
        ),
      ),
      body: Center(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your email and we will send you a password reset link',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                EmailFormField(
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                WideButton(text: 'Reset password', onPressed: saveForm)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
