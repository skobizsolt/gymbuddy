import 'package:gymbuddy/models/workout_step.dart';

final stepsData = [
  WorkoutStep(
    stepId: 1,
    workoutId: 1,
    stepNumber: 1,
    stepName: "Step 1",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
  ),
  WorkoutStep(
    stepId: 2,
    workoutId: 1,
    stepNumber: 2,
    stepName: "Step 2",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
  ),
  WorkoutStep(
    stepId: 3,
    workoutId: 1,
    stepNumber: 5,
    stepName: "Step 3 but moved to 5",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
  ),
  WorkoutStep(
    stepId: 4,
    workoutId: 1,
    stepNumber: 4,
    stepName: "Step 4",
    details: "This is a step for 30 sec",
    workoutType: WorkoutType.interval,
  ),
  WorkoutStep(
    stepId: 5,
    workoutId: 1,
    stepNumber: 3,
    stepName: "Step 5 but moved to 3",
    details: "This is a step for 10 reps",
    workoutType: WorkoutType.rep,
  ),
  WorkoutStep(
    stepId: 6,
    workoutId: 2,
    stepNumber: 1,
    stepName: "Step 1 in Test Workout 2",
    details: "This is a step for 10 sec",
    workoutType: WorkoutType.interval,
  ),
];
