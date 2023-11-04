// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_media_provider.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/carousel/carousel_image.dart';
import 'package:gymbuddy/widgets/carousel/carousel_with_indicator.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class WorkoutStepDetailsScreen extends ConsumerWidget {
  const WorkoutStepDetailsScreen({
    super.key,
    required this.step,
    required this.workoutId,
    required this.placeInList,
  });

  final WorkoutStep step;
  final int workoutId;
  final int placeInList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = WorkoutIds(workoutId: workoutId, stepId: step.stepId);
    final mediaRef = ref.watch(workoutStepMediaProvider(ids));
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

    //Renders all steps belongs with this workout

    return DribbleLayout(
      headerContent: Column(
        children: [
          // Title
          renderTitle(context, onPrimaryContainer),

          // Step number
          renderDetail(
            context,
            onPrimaryContainer,
            title: '$placeInList. step',
            icon: Icons.grid_3x3_outlined,
          ),
          // Step type
          renderDetail(context, onPrimaryContainer,
              title: FormatUtils.toCapitalized(
                  '${step.workoutType.name} based step'),
              icon: Icons.star_border_purple500_outlined),

          // Time to complete
          renderDetail(
            context,
            onPrimaryContainer,
            title:
                FormatUtils.toTimeString(Duration(seconds: step.estimatedTime)),
            icon: Icons.access_time_rounded,
          ),

          const SizedBox(
            height: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            renderMedia(mediaRef),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Description
                renderDescription(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Renders the Workouts name
  Widget renderTitle(BuildContext context, Color onPrimaryContainer) {
    return Row(
      children: [
        Expanded(
          child: Text(
            step.stepName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: onPrimaryContainer,
                  fontSize: 32,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Renders the total workout time and steps
  Widget renderDetail(
    BuildContext context,
    Color onPrimaryContainer, {
    required final String title,
    required final IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: onPrimaryContainer,
          size: 24,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: onPrimaryContainer,
              fontSize: 18,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Renders the media if added
  Widget renderMedia(mediaRef) {
    if (!mediaRef.hasValue) {
      return const SizedBox();
    }
    var images = mediaRef.value!;

    return images == null || images.isEmpty
        ? const SizedBox()
        : Column(children: [
            const Text("Media"),
            const SizedBox(
              width: 8,
            ),
            CarouselWithIndicator(
              images: images.map((e) => CarouselImage(file: File(e))).toList(),
            )
          ]);
  }

  // Renders the details if added
  Widget renderDescription() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InformationTag(
                child: Text(
                  step.details.isEmpty
                      ? "No description added for this step."
                      : step.details,
                  style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
