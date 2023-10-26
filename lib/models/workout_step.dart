class WorkoutStep {
  int stepId;
  int stepPosition;
  String stepName;
  String details;
  WorkoutType workoutType;
  int estimatedTime;

  WorkoutStep({
    required this.stepId,
    required this.stepPosition,
    required this.stepName,
    required this.details,
    required this.workoutType,
    required this.estimatedTime,
  });

  WorkoutStep copyWith({
    int? stepId,
    int? stepPosition,
    String? stepName,
    String? details,
    WorkoutType? workoutType,
    int? estimatedTime,
  }) {
    return WorkoutStep(
      stepId: stepId ?? this.stepId,
      stepPosition: stepPosition ?? this.stepPosition,
      stepName: stepName ?? this.stepName,
      details: details ?? this.details,
      workoutType: workoutType ?? this.workoutType,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }

  @override
  String toString() {
    return 'WorkoutStep(stepId: $stepId, stepPosition: $stepPosition, stepName: $stepName, details: $details, workoutType: $workoutType, estimatedTime: $estimatedTime)';
  }

  @override
  bool operator ==(covariant WorkoutStep other) {
    if (identical(this, other)) return true;

    return other.stepId == stepId &&
        other.stepPosition == stepPosition &&
        other.stepName == stepName &&
        other.details == details &&
        other.workoutType == workoutType &&
        other.estimatedTime == estimatedTime;
  }

  @override
  int get hashCode {
    return stepId.hashCode ^
        stepPosition.hashCode ^
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
