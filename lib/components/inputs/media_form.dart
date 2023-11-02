import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/models/workout_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:image_picker/image_picker.dart';

class WorkoutMediaForm extends StatefulWidget {
  final List<WorkoutImage> images;
  const WorkoutMediaForm({
    super.key,
    required this.images,
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
        widget.images.add(WorkoutImage(file: File(element.path)));
      });
    });
  }

  _buildImages() {
    return widget.images.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CarouselWithIndicator(images: _renderImages()),
          );
  }

  _renderImages() {
    return widget.images
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CarouselImage(
                  image: e.file,
                ),

                // Delete icon on top of image
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton.filled(
                      color: Theme.of(context).colorScheme.errorContainer,
                      style: const ButtonStyle().copyWith(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.onErrorContainer)),
                      onPressed: () => _removeImage(e),
                      icon: const Icon(Icons.delete)),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  _removeImage(WorkoutImage element) {
    setState(() {
      widget.images.remove(element);
    });
  }
}
