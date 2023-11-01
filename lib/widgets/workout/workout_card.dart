import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_interaction_provider.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';

class WorkoutCard extends ConsumerWidget {
  const WorkoutCard({super.key, required this.workoutId});
  final int workoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workoutRef = ref.watch(workoutByIdProvider(workoutId));
    var interactionsRef = ref.watch(likesForWorkoutProvider(workoutId));
    if (!workoutRef.hasValue || interactionsRef.isLoading) {
      return const SizedBox();
    }

    Workout workout = workoutRef.value!;
    AsyncValue<WorkoutDetailsResponse> generalStepDetails =
        ref.watch(workoutGeneralDetailsProvider(workout.workoutId));
    Future<void> selectWorkout(Workout workout) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => WorkoutDetailsScreen(
                workoutId: workout.workoutId,
              )),
        ),
      );
    }

    int likes = interactionsRef.value!.data() == null
        ? 0
        : interactionsRef.value!.data()!["likes"].length;

    Widget workoutDetails(int? totalSteps) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${workoutCategoryIcon[workout.category]} ' +
                  '${FormatUtils.toCapitalized(workout.category.name)}, ' +
                  '${(totalSteps == null || totalSteps == 0) ? "No" : totalSteps} steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  workoutDifficultyRating[workout.difficulty] as Widget,
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    FormatUtils.toCapitalized(workout.difficulty.name),
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '$likes ${likes == 1 ? "Like" : "Likes"}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return generalStepDetails.hasValue
        ? Card(
            child: InkWell(
              onTap: () {
                selectWorkout(workout);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        workoutDetails(generalStepDetails.value!.totalSteps),
                        Column(children: [
                          Text(
                            '${generalStepDetails.value!.estimatedTimeInMinutes!}\nmins',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
