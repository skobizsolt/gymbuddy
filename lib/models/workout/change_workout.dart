import 'package:flutter/foundation.dart';

import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';

class ChangeWorkoutDto {
  String? title;
  String? description;
  WorkoutCategory? category;
  WorkoutDifficulty? difficulty;
  List<ChangeWorkoutStepDto> steps;

  ChangeWorkoutDto({
    this.title,
    this.description,
    this.category,
    this.difficulty,
    required this.steps,
  });

  ChangeWorkoutDto copyWith({
    String? userId,
    String? title,
    String? description,
    WorkoutCategory? category,
    WorkoutDifficulty? difficulty,
    List<ChangeWorkoutStepDto>? steps,
  }) {
    return ChangeWorkoutDto(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toAddWorkoutMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category == null ? null : category!.name.toUpperCase(),
      'difficulty': difficulty == null ? null : difficulty!.name.toUpperCase(),
      'steps': steps.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toEditWorkoutMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category == null ? null : category!.name.toUpperCase(),
      'difficulty': difficulty == null ? null : difficulty!.name.toUpperCase(),
    };
  }

  factory ChangeWorkoutDto.fromMap(Map<String, dynamic> map) {
    return ChangeWorkoutDto(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null
          ? WorkoutCategory.values.byName(map['category'])
          : null,
      difficulty: map['difficulty'] != null
          ? WorkoutDifficulty.values.byName(map['difficulty'])
          : null,
      steps: List<ChangeWorkoutStepDto>.from(
        (map['steps'] as List<int>).map<ChangeWorkoutStepDto>(
          (x) => ChangeWorkoutStepDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'ChangeWorkoutDto(title: $title, description: $description, category: $category, difficulty: $difficulty, steps: $steps)';
  }

  @override
  bool operator ==(covariant ChangeWorkoutDto other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.category == category &&
        other.difficulty == difficulty &&
        listEquals(other.steps, steps);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        difficulty.hashCode ^
        steps.hashCode;
  }
}
