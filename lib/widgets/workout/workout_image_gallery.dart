import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:gymbuddy/providers/workout_media_provider.dart';
import 'package:gymbuddy/widgets/carousel/carousel_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/carousel/custom_network_image.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class WorkoutImageGallery extends ConsumerWidget {
  final bool doAddHeader;
  final int workoutId;
  final int stepId;
  final double? height;
  final bool autoPlay;
  final bool enlargeCenterPage;
  const WorkoutImageGallery({
    super.key,
    required this.workoutId,
    required this.stepId,
    this.height,
    this.doAddHeader = false,
    this.autoPlay = false,
    this.enlargeCenterPage = false,
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

    final convertedImageFiles = mediaImages
        .map(
          (e) => CarouselImage(
            image: CustomNetworkImage(url: e),
          ),
        )
        .toList();
    return doAddHeader
        ? _renderContentWithHeader(context, convertedImageFiles)
        : _renderGallery(convertedImageFiles);
  }

  _renderContentWithHeader(
    BuildContext context,
    List<CarouselImage> convertedImageFiles,
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

  _renderGallery(List<CarouselImage> convertedImageFiles) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselWithIndicator(
          data: convertedImageFiles,
          autoPlay: autoPlay,
          enlargeCenterPage: enlargeCenterPage,
          height: height,
        ),
      ],
    );
  }
}
