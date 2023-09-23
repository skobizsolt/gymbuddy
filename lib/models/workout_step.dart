class WorkoutStep {
  WorkoutStep({
    required this.stepNumber,
    required this.stepName,
    required this.details,
    required this.workoutType,
    required this.estimatedTime,
  });

  int stepNumber;
  String stepName;
  String details;
  WorkoutType workoutType;
  int estimatedTime;
}

enum WorkoutType {
  interval,
  rep;
}
