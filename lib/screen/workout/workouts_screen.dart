// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({
    super.key,
    required this.title,
    required this.workouts,
  });

  final String title;
  final List<Workout> workouts;

  Widget _renderWorkouts({required List<Workout> workoutList}) {
    return ListView.builder(
      itemCount: workoutList.length,
      itemBuilder: (context, index) {
        return WorkoutCard(workout: workoutList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget renderContent() {
      if (workouts.isEmpty) {
        return const NoContentText(title: 'Uh oh ... nothing here yet!');
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _renderWorkouts(workoutList: workouts),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: renderContent(),
    );
  }
}
