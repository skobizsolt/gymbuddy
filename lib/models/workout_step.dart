class WorkoutStep {
  int stepNumber;
  String stepName;
  String details;
  WorkoutType workoutType;
  int estimatedTime;

  WorkoutStep({
    required this.stepNumber,
    required this.stepName,
    required this.details,
    required this.workoutType,
    required this.estimatedTime,
  });

  @override
  bool operator ==(covariant WorkoutStep other) {
    if (identical(this, other)) return true;

    return other.stepNumber == stepNumber &&
        other.stepName == stepName &&
        other.details == details &&
        other.workoutType == workoutType &&
        other.estimatedTime == estimatedTime;
  }

  @override
  int get hashCode {
    return stepNumber.hashCode ^
        stepName.hashCode ^
        details.hashCode ^
        workoutType.hashCode ^
        estimatedTime.hashCode;
  }
}

enum WorkoutType {
  interval,
  rep;
}
