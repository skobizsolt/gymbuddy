import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
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

    Widget workoutDetails() {
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
              '${workoutCategoryIcon[workout.category]} ${workout.category.name}, ${workout.steps.toString()} steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            workoutDifficultyRating[workout.difficulty] as Widget,
          ],
        ),
      );
    }

    return Card(
      child: InkWell(
        onTap: () {
          selectWorkout(workout);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  workoutDetails(),
                  Column(children: [
                    Text(
                      '${workout.estimatedTimeInMinutes.toString()}\nmins',
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
  }
}
