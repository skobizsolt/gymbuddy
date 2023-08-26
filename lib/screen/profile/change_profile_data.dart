import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ChangeProfileData {
  UserDto userDto;
  ChangeProfileData({
    required this.userDto,
  });

  void showChangeData(BuildContext context) {
    GlobalKey<FormState> _form = GlobalKey<FormState>();

    _saveForm() {
      final bool isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      _form.currentState!.save();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(vertical: 16),
          contentPadding: const EdgeInsets.all(8),
          title: const Text(
            'Change user data',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Cancel'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text(
                'Save',
              ),
            )
          ],
          content: _getcontent(context, _form),
        );
      },
    );
  }

  Widget _getcontent(BuildContext context, GlobalKey<FormState> form) {
    final _currentPhoto = userDto.profileImageUrl == null
        ? MemoryImage(kTransparentImage)
        : NetworkImage(userDto.profileImageUrl!);

    return GestureDetector(
      onTap: () => KeyboardService().unFocusKeyboard(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile picture
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ProfilePicture(
                      picture: _currentPhoto,
                      size: 48,
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    KeyboardService().unFocusKeyboard(context);
                    _showModalSheet(context);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
              ],
            ),
            Text(
              'Your photo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Text(
                    'Your name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextFormField(
                    hintText: 'First name',
                    initialValue: userDto.firstName,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultTextFormField(
                    hintText: 'Last name',
                    initialValue: userDto.lastName,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Choose Photo'),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt_rounded),
              title: Text('Camera'),
            ),
          ],
        );
      },
    );
  }
}
