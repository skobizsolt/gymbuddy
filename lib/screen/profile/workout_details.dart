import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';

class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          workout.title,
          maxLines: 1,
        ),
      ),
      body: const NoContentText(
        title: "Nothing here",
      ),
    );
  }
}
