import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';

class WorkoutInternalDataMapper {
  List<WorkoutStep> toWorkoutStepList(List<ChangeWorkoutStepDto> steps) {
    return steps
        .map(
          (e) => toWorkoutStep(e, steps.indexOf(e)),
        )
        .toList();
  }

  WorkoutStep toWorkoutStep(ChangeWorkoutStepDto step, int stepNumber) {
    return WorkoutStep(
        stepNumber: stepNumber,
        stepName: step.stepName!,
        details: step.details!,
        workoutType: step.workoutType!,
        estimatedTime: step.estimatedTime!);
  }
}
