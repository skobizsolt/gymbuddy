import 'package:flutter/material.dart';

import 'package:gymbuddy/widgets/utils/themed_icon.dart';

class Workout {
  const Workout({
    required this.workoutId,
    required this.userId,
    required this.title,
    this.description,
    required this.category,
    required this.registeredOn,
    required this.lastModified,
    required this.difficulty,
  });

  final int workoutId;
  final String userId;
  final String title;
  final String? description;
  final WorkoutCategory category;
  final DateTime registeredOn;
  final DateTime lastModified;
  final WorkoutDifficulty difficulty;

  Map<String, dynamic> toChangeWorkoutDto() {
    return <String, dynamic>{
      'workoutId': workoutId,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category.name,
      'difficulty': difficulty.name,
    };
  }
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
