import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';

class WorkoutCard extends ConsumerWidget {
  const WorkoutCard({super.key, required this.workoutId});
  final int workoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workoutRef = ref.watch(workoutByIdProvider(workoutId));
    if (!workoutRef.hasValue) {
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
                  '${(totalSteps ?? 0).toString()} steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            workoutDifficultyRating[workout.difficulty] as Widget,
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
                          )
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
