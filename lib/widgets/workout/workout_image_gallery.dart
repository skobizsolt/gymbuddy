import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:gymbuddy/providers/workout_media_provider.dart';
import 'package:gymbuddy/widgets/carousel/carousel_network_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class WorkoutImageGallery extends ConsumerWidget {
  final bool doAddHeader;
  final int workoutId;
  final int stepId;
  const WorkoutImageGallery({
    super.key,
    required this.workoutId,
    required this.stepId,
    this.doAddHeader = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = WorkoutIds(workoutId: workoutId, stepId: stepId);
    final mediaRef = ref.watch(workoutStepMediaProvider(ids));

    if (mediaRef.isLoading || !mediaRef.hasValue) {
      return const Center(
          child: WaitingSpinner(
        title: 'Loading media details...',
      ));
    }

    final mediaImages = mediaRef.value!;

    if (mediaImages.isEmpty) {
      return const SizedBox();
    }

    final convertedImageFiles =
        mediaImages.map((e) => CarouselNetworkImage(url: e)).toList();
    return doAddHeader
        ? _renderContentWithHeader(context, convertedImageFiles)
        : _renderGallery(convertedImageFiles);
  }

  _renderContentWithHeader(
    BuildContext context,
    List<CarouselNetworkImage> convertedImageFiles,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Media",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        _renderGallery(convertedImageFiles)
      ],
    );
  }

  _renderGallery(List<CarouselNetworkImage> convertedImageFiles) {
    return InformationTag(
      margin: doAddHeader ? const EdgeInsets.only(bottom: 16) : null,
      child: CarouselWithIndicator(
        images: convertedImageFiles,
      ),
    );
  }
}
