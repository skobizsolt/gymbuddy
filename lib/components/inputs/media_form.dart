import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/widgets/carousel/carousel_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/carousel/custom_file_image.dart';
import 'package:image_picker/image_picker.dart';

class WorkoutMediaForm extends StatefulWidget {
  final List<File> files;
  const WorkoutMediaForm({
    super.key,
    required this.files,
  });

  @override
  State<WorkoutMediaForm> createState() => _WorkoutMediaFormState();
}

class _WorkoutMediaFormState extends State<WorkoutMediaForm> {
  @override
  Widget build(BuildContext context) {
    return FormCategory(
      title: "Pictures, illustrations",
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addImages,
                icon: const Icon(Icons.add),
                label: Text(
                  "Add media",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                style: const ButtonStyle().copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorDark),
                    surfaceTintColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorDark)),
              ),
            ),
          ],
        ),
        _buildImages(),
      ],
    );
  }

  _addImages() async {
    List<XFile> resultList = await ImagePicker().pickMultiImage();
    if (resultList.isEmpty) {
      return;
    }

    setState(() {
      resultList.forEach((element) {
        widget.files.add(File(element.path));
      });
    });
  }

  _buildImages() {
    return widget.files.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CarouselWithIndicator(
                height: GlobalValues.getScreenSize(context).height * 0.33,
                images: _renderImages()),
          );
  }

  _renderImages() {
    return widget.files
        .map(
          (file) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CarouselImage(
                  image: CustomFileImage(file: file),
                ),

                // Delete icon on top of image
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton.filled(
                      color: Theme.of(context).colorScheme.errorContainer,
                      style: const ButtonStyle().copyWith(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.onErrorContainer)),
                      onPressed: () => _removeImage(file),
                      icon: const Icon(Icons.delete)),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  _removeImage(File element) {
    setState(() {
      widget.files.remove(element);
    });
  }
}
