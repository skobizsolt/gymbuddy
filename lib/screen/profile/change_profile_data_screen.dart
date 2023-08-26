import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/models/user_dto.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/profile_picture.dart';

class ChangeProfileDataScreen extends StatefulWidget {
  final UserDto userDto;
  const ChangeProfileDataScreen({
    super.key,
    required this.userDto,
  });

  @override
  State<ChangeProfileDataScreen> createState() => _ChangeProfileContentState();
}

class _ChangeProfileContentState extends State<ChangeProfileDataScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  File? _localphoto = null;
  UserDto? _updatedData;

  @override
  void initState() {
    super.initState();
    _updatedData = widget.userDto;
  }

  _saveForm() async {
    final bool isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    ProfileDataService().updateProfileData(_updatedData, _localphoto);
    Navigator.of(context).pop();
    showSucessSnackBar(context, 'Your data has updated!');
  }

  _ChangeProfileContentState();

  _showModalSheet(
      BuildContext context, StateSetter setState, File? localphoto) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose Photo'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _pickImage(ImageSource imageSource) async {
    final image = await ImagePicker()
        .pickImage(source: imageSource, imageQuality: 50, maxWidth: 150);
    if (image == null) {
      return;
    }
    setState(
      () => _localphoto = File(image.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _currentPhoto = widget.userDto.profileImageUrl == null
        ? MemoryImage(kTransparentImage)
        : NetworkImage(widget.userDto.profileImageUrl!);

    return Scaffold(
      body: GestureDetector(
        onTap: () => KeyboardService().unFocusKeyboard(context),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                picture: _localphoto == null
                                    ? _currentPhoto
                                    : FileImage(_localphoto!),
                                size: 48,
                              ),
                            ),
                          ),
                          IconButton.filled(
                            onPressed: () {
                              KeyboardService().unFocusKeyboard(context);
                              _showModalSheet(context, setState, _localphoto);
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

                      // User data
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, bottom: 4.0),
                            child: Text(
                              'Your name',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultTextFormField(
                              hintText: 'First name',
                              initialValue: widget.userDto.firstName,
                              onSaved: (value) {
                                _updatedData!.firstName = value!;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DefaultTextFormField(
                              hintText: 'Last name',
                              initialValue: widget.userDto.lastName,
                              onSaved: (value) {
                                _updatedData!.lastName = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Cancel'),
                            ),
                            FilledButton.icon(
                              onPressed: _saveForm,
                              icon: const Icon(Icons.save_alt_outlined),
                              label: const Text(
                                'Save',
                              ),
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
