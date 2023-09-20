import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';

class ChangeWorkoutDto {
  ChangeWorkoutDto({
    required this.userId,
    this.title,
    this.description,
    this.category,
    this.difficulty,
    required this.steps,
  });

  String userId;
  String? title;
  String? description;
  WorkoutCategory? category;
  WorkoutDifficulty? difficulty;
  List<ChangeWorkoutStepDto> steps;
}
