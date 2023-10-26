// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateStepRecord {
  int? workoutId;
  int? stepId;
  String? sessionId;
  int? duration;
  CreateStepRecord({
    this.workoutId,
    this.stepId,
    this.sessionId,
    this.duration,
  });

  CreateStepRecord copyWith({
    int? workoutId,
    int? stepId,
    String? sessionId,
    int? duration,
  }) {
    return CreateStepRecord(
      workoutId: workoutId ?? this.workoutId,
      stepId: stepId ?? this.stepId,
      sessionId: sessionId ?? this.sessionId,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workoutId': workoutId,
      'stepId': stepId,
      'sessionId': sessionId,
      'duration': duration,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CreateStepRecord(workoutId: $workoutId, stepId: $stepId, sessionId: $sessionId, duration: $duration)';
  }

  @override
  bool operator ==(covariant CreateStepRecord other) {
    if (identical(this, other)) return true;

    return other.workoutId == workoutId &&
        other.stepId == stepId &&
        other.sessionId == sessionId &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return workoutId.hashCode ^
        stepId.hashCode ^
        sessionId.hashCode ^
        duration.hashCode;
  }
}
