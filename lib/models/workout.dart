// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/utils/themed_icon.dart';

class Workout {
  const Workout(
      {required this.workoutId,
      required this.userId,
      required this.title,
      this.description,
      required this.category,
      required this.registeredOn,
      required this.lastModified,
      required this.difficulty,
      required this.steps,
      required this.estimatedTimeInMinutes});

  final int workoutId;
  final int userId;
  final String title;
  final String? description;
  final WorkoutCategory category;
  final DateTime registeredOn;
  final DateTime lastModified;
  final WorkoutDifficulty difficulty;
  final int steps;
  final int estimatedTimeInMinutes;
}

Map<WorkoutDifficulty, Row> get workoutDifficultyRating {
  const emptyStar = ThemedIcon(Icons.star_border);
  const star = ThemedIcon(Icons.star);

  return {
    WorkoutDifficulty.easy: const Row(children: [star, emptyStar, emptyStar]),
    WorkoutDifficulty.intermediate:
        const Row(children: [star, star, emptyStar]),
    WorkoutDifficulty.hard: const Row(children: [star, star, star]),
  };
}

Map<WorkoutCategory, String> get workoutCategoryIcon {
  return const {
    WorkoutCategory.strength: '🏋️‍♂️',
    WorkoutCategory.endurance: '🏃‍♂️',
    WorkoutCategory.flexibility: '🤸‍♂️',
    WorkoutCategory.balance: '🧘‍♀️',
  };
}

enum WorkoutDifficulty { easy, intermediate, hard }

enum WorkoutCategory { endurance, strength, balance, flexibility }
