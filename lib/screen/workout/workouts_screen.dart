// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_data.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({
    super.key,
    required this.selectedCategory,
    required this.title,
  });

  final WorkoutCategory selectedCategory;
  final String title;

  Widget renderWorkoutGroup({required List<Workout> workoutList}) {
    return ListView.builder(
      itemCount: workoutList.length,
      itemBuilder: (context, index) {
        return WorkoutCard(workout: workoutList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Workout> filteredWorkouts = workoutData
        .where((workout) => workout.category == selectedCategory)
        .toList();

    Widget renderContent() {
      if (workoutData == null) {
        return const NoContentText(title: 'Uh oh ... nothing here yet!');
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: renderWorkoutGroup(workoutList: filteredWorkouts),
                ),
              ],
            ),
          ),
        );
      }
    }

    return renderContent();
  }
}
