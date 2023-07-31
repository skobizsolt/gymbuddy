import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workout_details.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    void selectWorkout(Workout workout) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: ((context) => WorkoutDetails(workout: workout))),
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
              workout.description ?? 'No additional description',
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall,
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
          width: double.infinity,
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
