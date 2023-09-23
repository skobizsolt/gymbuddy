// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step_request.dart';

class ChangeWorkoutRequest {
  String? title;
  String? description;
  WorkoutCategory? category;
  WorkoutDifficulty? difficulty;
  List<ChangeWorkoutStepRequest> steps;

  ChangeWorkoutRequest({
    this.title,
    this.description,
    this.category,
    this.difficulty,
    required this.steps,
  });

  ChangeWorkoutRequest copyWith({
    String? userId,
    String? title,
    String? description,
    WorkoutCategory? category,
    WorkoutDifficulty? difficulty,
    List<ChangeWorkoutStepRequest>? steps,
  }) {
    return ChangeWorkoutRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      steps: steps ?? this.steps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category == null ? null : category!.name.toUpperCase(),
      'difficulty': difficulty == null ? null : difficulty!.name.toUpperCase(),
      'steps': steps.map((x) => x.toMap()).toList(),
    };
  }

  factory ChangeWorkoutRequest.fromMap(Map<String, dynamic> map) {
    return ChangeWorkoutRequest(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null
          ? WorkoutCategory.values.byName(map['category'])
          : null,
      difficulty: map['difficulty'] != null
          ? WorkoutDifficulty.values.byName(map['difficulty'])
          : null,
      steps: List<ChangeWorkoutStepRequest>.from(
        (map['steps'] as List<int>).map<ChangeWorkoutStepRequest>(
          (x) => ChangeWorkoutStepRequest.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeWorkoutRequest.fromJson(String source) =>
      ChangeWorkoutRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChangeWorkoutRequest(title: $title, description: $description, category: $category, difficulty: $difficulty, steps: $steps)';
  }

  @override
  bool operator ==(covariant ChangeWorkoutRequest other) {
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
