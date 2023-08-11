enum WorkoutType {
  interval,
  rep;
}

class WorkoutStep {
  WorkoutStep(
      {required this.stepId,
      required this.workoutId,
      required this.stepNumber,
      required this.stepName,
      required this.details,
      required this.workoutType,
      this.expanded = false});

  int stepId;
  int workoutId;
  int stepNumber;
  String stepName;
  String details;
  WorkoutType workoutType;
  bool expanded;
}
