import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/media/media_form_image.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/carousel/custom_file_image.dart';
import 'package:image_picker/image_picker.dart';

class WorkoutMediaForm extends StatefulWidget {
  final List<File> images;
  const WorkoutMediaForm({
    super.key,
    required this.images,
  });

  @override
  State<WorkoutMediaForm> createState() => _WorkoutMediaFormState();
}

class _WorkoutMediaFormState extends State<WorkoutMediaForm> {
  late final List<File> localImages;

  initState() {
    super.initState();
    localImages = widget.images;
  }

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
        _buildlImages(),
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
        localImages.add(File(element.path));
      });
    });
  }

  _buildlImages() {
    return localImages.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CarouselWithIndicator(
                height: GlobalValues.getScreenSize(context).height * 0.33,
                data: _renderImages()),
          );
  }

  List<Widget> _renderImages() {
    return List<Widget>.from(localImages
        .map(
          (item) => MediaFormImage(
            image: CustomFileImage(file: item),
            onDeleteItem: () => _removeImage(item),
          ),
        )
        .toList());
  }

  _removeImage(File element) {
    setState(() {
      localImages.remove(element);
    });
  }
}
