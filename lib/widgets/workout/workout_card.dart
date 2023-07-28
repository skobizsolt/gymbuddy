import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/profile/workout_details.dart';
import 'package:gymbuddy/widgets/utils/containered_text.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ContaineredText(
              text: workout.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            ContaineredText(
              text: workout.description ?? 'No additional description',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ContaineredText(
              text: '${workout.steps.toString()} steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            workoutDifficultyRating[workout.difficulty],
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
                children: [
                  workoutDetails(),
                  const Spacer(),
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
