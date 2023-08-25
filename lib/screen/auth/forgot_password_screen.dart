import 'package:flutter/material.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/service/auth/user_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';
import 'package:ionicons/ionicons.dart';

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
    return GestureDetector(
      onTap: () => KeyboardService().unFocusKeyboard(context),
      child: Scaffold(
        body: Center(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.key,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Enter your email so we can send you a password reset link',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      EmailFormField(
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: WideButton(
                                icon: Icons.arrow_back,
                                text: 'Cancel',
                                color: Colors.transparent,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: WideButton(
                                  text: 'Reset password', onPressed: saveForm),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
