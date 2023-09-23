import 'package:gymbuddy/models/workout/change_workout_step_request.dart';
import 'package:gymbuddy/models/workout_step.dart';

class WorkoutInternalDataMapper {
  List<WorkoutStep> toWorkoutStepList(List<ChangeWorkoutStepRequest> steps) {
    return steps
        .map(
          (e) => toWorkoutStep(e, steps.indexOf(e)),
        )
        .toList();
  }

  WorkoutStep toWorkoutStep(ChangeWorkoutStepRequest step, int stepIndex) {
    return WorkoutStep(
        stepNumber: stepIndex,
        stepName: step.stepName!,
        details: step.details!,
        workoutType: step.workoutType!,
        estimatedTime: step.estimatedTime!);
  }
}
