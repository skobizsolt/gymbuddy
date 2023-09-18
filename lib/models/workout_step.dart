class WorkoutStep {
  WorkoutStep({
    required this.stepId,
    required this.workoutId,
    required this.stepNumber,
    required this.stepName,
    required this.details,
    required this.workoutType,
  });

  int stepId;
  int workoutId;
  int stepNumber;
  String stepName;
  String details;
  WorkoutType workoutType;
}

enum WorkoutType {
  interval,
  rep;
}
