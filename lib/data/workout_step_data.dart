import 'package:gymbuddy/models/workout_step.dart';

final stepsData = [
  WorkoutStep(
    stepNumber: 1,
    stepName: "Step 1",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
    estimatedTime: 8,
  ),
  WorkoutStep(
    stepNumber: 2,
    stepName: "Step 2",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
    estimatedTime: 18,
  ),
  WorkoutStep(
    stepNumber: 5,
    stepName: "Step 3 but moved to 5",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
    estimatedTime: 28,
  ),
  WorkoutStep(
    stepNumber: 4,
    stepName: "Step 4",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
    estimatedTime: 38,
  ),
  WorkoutStep(
    stepNumber: 3,
    stepName: "Step 5 but moved to 3",
    details: "This is a step for 10 reps",
    workoutType: WorkoutType.rep,
    estimatedTime: 48,
  ),
  WorkoutStep(
    stepNumber: 1,
    stepName: "Step 1 in Test Workout 2",
    details: "This is a step for 10 sec",
    workoutType: WorkoutType.interval,
    estimatedTime: 68,
  ),
];
