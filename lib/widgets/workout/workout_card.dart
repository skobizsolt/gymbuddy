import 'package:flutter/material.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  late Workout workoutData;
  late var generalStepDetails;

  @override
  void initState() {
    super.initState();
    workoutData = widget.workout;
    generalStepDetails =
        WorkoutService().getGeneralStepDetails(workoutData.workoutId, context);
  }

  updateData(Workout? value) {
    if (value == null || workoutData == value) {
      return;
    }
    setState(() {
      workoutData = value;
      generalStepDetails = WorkoutService()
          .getGeneralStepDetails(workoutData.workoutId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectWorkout(Workout workout) async {
      final Workout? returnedValue =
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
      updateData(returnedValue);
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

    return StreamBuilder<WorkoutDetailsResponse>(
        stream: generalStepDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          return Card(
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
                        workoutDetails(snapshot.data!.totalSteps),
                        Column(children: [
                          Text(
                            '${snapshot.data!.estimatedTimeInMinutes!}\nmins',
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
          );
        });
  }
}
