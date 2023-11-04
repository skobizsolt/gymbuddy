class WorkoutIds {
  int workoutId;
  int stepId;
  WorkoutIds({
    required this.workoutId,
    required this.stepId,
  });

  WorkoutIds copyWith({
    int? workoutId,
    int? stepId,
  }) {
    return WorkoutIds(
      workoutId: workoutId ?? this.workoutId,
      stepId: stepId ?? this.stepId,
    );
  }

  @override
  String toString() => 'WorkoutIds(workoutId: $workoutId, stepId: $stepId)';

  @override
  bool operator ==(covariant WorkoutIds other) {
    if (identical(this, other)) return true;

    return other.workoutId == workoutId && other.stepId == stepId;
  }

  @override
  int get hashCode => workoutId.hashCode ^ stepId.hashCode;
}
