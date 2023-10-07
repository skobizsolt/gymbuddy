import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';

class WorkoutCard extends ConsumerStatefulWidget {
  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  ConsumerState<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends ConsumerState<WorkoutCard> {
  late Workout workoutData;

  @override
  void initState() {
    super.initState();
    workoutData = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<WorkoutDetailsResponse> generalStepDetails =
        ref.watch(workoutGeneralDetailsProvider(workoutData.workoutId));
    Future<void> selectWorkout(Workout workout) async {
      await WorkoutStepService().getSteps(workout.workoutId, context).then(
            (steps) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => WorkoutDetailsScreen(
                      workout: workout,
                      steps: steps,
                    )),
              ),
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
              widget.workout.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${workoutCategoryIcon[workoutData.category]} ${FormatUtils.toCapitalized(workoutData.category.name)}, ${(totalSteps ?? 0).toString()} steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            workoutDifficultyRating[workoutData.difficulty] as Widget,
          ],
        ),
      );
    }

    return generalStepDetails.hasValue
        ? Card(
            child: InkWell(
              onTap: () {
                selectWorkout(workoutData);
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
