import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/media/media_form_image.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:gymbuddy/providers/workout_media_provider.dart';
import 'package:gymbuddy/service/workout/workout_step_media_service.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/carousel/custom_network_image.dart';
import 'package:image_picker/image_picker.dart';

class EditWorkoutMediaForm extends ConsumerWidget {
  final int workoutId;
  final int stepId;
  const EditWorkoutMediaForm({
    super.key,
    required this.workoutId,
    required this.stepId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaRef = ref.watch(workoutStepMediaProvider(
        WorkoutIds(workoutId: workoutId, stepId: stepId)));

    if (mediaRef.isLoading || mediaRef.hasError) {
      return const SizedBox();
    }

    final images = mediaRef.value == null
        ? List<CustomNetworkImage>.from([])
        : mediaRef.value!
            .map(
              (item) => CustomNetworkImage(
                url: item,
              ),
            )
            .toList();

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
        _buildlImages(context, images),
      ],
    );
  }

  _addImages() async {
    List<XFile> resultList = await ImagePicker().pickMultiImage();
    if (resultList.isEmpty) {
      return;
    }

    List<File> addedImageFiles =
        resultList.map((item) => File(item.path)).toList();

    WorkoutStepMediaService().saveImages(
      images: addedImageFiles,
      workoutId: workoutId,
      stepId: stepId,
      crudType: CrudType.edit,
    );
  }

  _buildlImages(BuildContext context, List<CustomNetworkImage> images) {
    return images.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CarouselWithIndicator(
                height: GlobalValues.getScreenSize(context).height * 0.33,
                images: _renderImages(context, images)),
          );
  }

  List<Widget> _renderImages(
      BuildContext context, List<CustomNetworkImage> images) {
    return List<Widget>.from(images
        .map(
          (item) => MediaFormImage(
            image: item,
            onDeleteItem: () => _removeImage(item),
          ),
        )
        .toList());
  }

  _removeImage(Widget element) {
    final imageUrl = (element as CustomNetworkImage).url;
    WorkoutStepMediaService().deleteImage(
      url: imageUrl,
      workoutId: workoutId,
      stepId: stepId,
    );
  }
}
