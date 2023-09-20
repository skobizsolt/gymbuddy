import 'package:gymbuddy/models/workout_step.dart';

class ChangeWorkoutStepDto {
  ChangeWorkoutStepDto(
      {this.stepName, this.details, this.workoutType, this.estimatedTime});

  String? stepName;
  String? details;
  WorkoutType? workoutType;
  int? estimatedTime;
}
