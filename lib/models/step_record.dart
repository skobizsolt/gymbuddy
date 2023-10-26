// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StepRecord {
  int? stepId;
  DateTime? completedAt;
  Duration? duration;
  StepRecord({
    this.stepId,
    this.completedAt,
    this.duration,
  });

  StepRecord copyWith({
    int? stepId,
    DateTime? completedAt,
    Duration? duration,
  }) {
    return StepRecord(
      stepId: stepId ?? this.stepId,
      completedAt: completedAt ?? this.completedAt,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stepId': stepId,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'duration': duration == null ? 0 : duration!.inSeconds,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'StepRecord(stepId: $stepId, completedAt: $completedAt, duration: $duration)';

  @override
  bool operator ==(covariant StepRecord other) {
    if (identical(this, other)) return true;

    return other.stepId == stepId &&
        other.completedAt == completedAt &&
        other.duration == duration;
  }

  @override
  int get hashCode =>
      stepId.hashCode ^ completedAt.hashCode ^ duration.hashCode;
}
