import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout_step.dart';

class WorkoutModelMapper {
  List<Workout> toWorkoutList(WorkoutListResponse response) {
    if (response.workouts == null) {
      return [];
    }
    return response.workouts!.map(toWorkout).toList();
  }

  Workout toWorkout(WorkoutResponse workoutDto) {
    return Workout(
        workoutId: workoutDto.workoutId!,
        userId: workoutDto.userId!,
        title: workoutDto.title!,
        description: workoutDto.description,
        category: WorkoutCategory.values.byName(workoutDto.category!.name),
        registeredOn: workoutDto.registeredOn!,
        lastModified: workoutDto.lastModified!,
        difficulty:
            WorkoutDifficulty.values.byName(workoutDto.difficulty!.name),
        steps: workoutDto.stepDetails!.totalSteps!,
        estimatedTimeInMinutes:
            workoutDto.stepDetails!.estimatedTimeInMinutes!);
  }

  List<WorkoutStep> toWorkoutSteps(List<WorkoutStepResponse> steps) {
    return steps.map(toWorkoutStep).toList();
  }

  WorkoutStep toWorkoutStep(WorkoutStepResponse step) {
    return WorkoutStep(
        stepNumber: step.stepNumber!,
        stepName: step.stepName!,
        details: step.details!,
        workoutType: WorkoutType.values.byName(step.workoutType!.name),
        estimatedTime: step.estimatedTime!);
  }
}
