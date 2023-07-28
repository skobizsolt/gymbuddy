// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/utils/themed_icon.dart';

enum WorkoutDifficulty { EASY, INTERMEDIATE, HARD }

class Workout {
  const Workout(
      {required this.workoutId,
      required this.userId,
      required this.title,
      this.description,
      required this.registeredOn,
      required this.lastModified,
      required this.difficulty,
      required this.steps,
      required this.estimatedTimeInMinutes});

  final int workoutId;
  final int userId;
  final String title;
  final String? description;
  final DateTime registeredOn;
  final DateTime lastModified;
  final WorkoutDifficulty difficulty;
  final int steps;
  final int estimatedTimeInMinutes;
}

get workoutDifficultyRating {
  final emptyStar = ThemedIcon(Icons.star_border);
  final star = ThemedIcon(Icons.star);

  return {
    WorkoutDifficulty.EASY: Row(children: [star, emptyStar, emptyStar]),
    WorkoutDifficulty.INTERMEDIATE: Row(children: [star, star, emptyStar]),
    WorkoutDifficulty.HARD: Row(children: [star, star, star]),
  };
}
