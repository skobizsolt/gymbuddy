// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_data.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/option_text.dart';

import '../widgets/workout/workout_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  static final List<Workout> _popularWorkouts =
      List.of(workouts).take(2).toList();

  static final List<Workout> _topPicks =
      List.of(workouts).getRange(1, 3).toList();

  Widget renderWorkoutGroup({
    required List<Workout> workoutList,
    required String groupTitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        OptionText(
          groupTitle,
        ),
        ...workoutList.map((workout) => WorkoutCard(workout: workout))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget renderContent() {
      if (workouts == null) {
        return const NoContentText(
          title: 'Uh oh ... nothing here yet!',
          details: 'Let\'s add a new workout!',
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            renderWorkoutGroup(
              workoutList: _popularWorkouts,
              groupTitle: 'Currently Popular',
            ),
            SizedBox(
              height: 20,
            ),
            renderWorkoutGroup(
              workoutList: _topPicks,
              groupTitle: 'Our top picks',
            )
          ],
        ),
      );
    }

    return renderContent();
  }
}
