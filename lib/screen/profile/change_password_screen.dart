import 'package:flutter/material.dart';
import 'package:gymbuddy/components/inputs/password_form_field.dart';
import 'package:gymbuddy/models/auth/change_password_dto.dart';
import 'package:gymbuddy/service/auth/user_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';
import 'package:ionicons/ionicons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwords = ChangePasswordDto();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void submitForm(BuildContext context) {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    UserService().changePassword(context, _passwords);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardService().unFocusKeyboard(context);
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Ionicons.lock_closed,
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Change your password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PasswordFormField(
                        hintText: 'Old Password',
                        onsaved: (value) =>
                            _passwords.oldPassword = value!.trim(),
                      ),
                      PasswordFormField(
                        hintText: 'New Password',
                        onsaved: (value) =>
                            _passwords.newPassword = value!.trim(),
                      ),
                      PasswordFormField(
                        hintText: 'Repeat new password',
                        onsaved: (value) =>
                            _passwords.newPasswordAgain = value!.trim(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: WideButton(
                                onPressed: () => Navigator.of(context).pop(),
                                color: Colors.transparent,
                                icon: Icons.arrow_back,
                                text: 'Cancel',
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: WideButton(
                                    text: 'Change password',
                                    onPressed: () => submitForm(context))),
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
