// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gymbuddy/models/workout_step.dart';

class ChangeWorkoutStepRequest {
  String? stepName;
  String? details;
  WorkoutType? workoutType;
  int? estimatedTime;
  ChangeWorkoutStepRequest({
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  ChangeWorkoutStepRequest copyWith({
    String? stepName,
    String? details,
    WorkoutType? workoutType,
    int? estimatedTime,
  }) {
    return ChangeWorkoutStepRequest(
      stepName: stepName ?? this.stepName,
      details: details ?? this.details,
      workoutType: workoutType ?? this.workoutType,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stepName': stepName,
      'details': details,
      'workoutType':
          workoutType == null ? null : workoutType!.name.toUpperCase(),
      'estimatedTime': estimatedTime,
    };
  }

  factory ChangeWorkoutStepRequest.fromMap(Map<String, dynamic> map) {
    return ChangeWorkoutStepRequest(
      stepName: map['stepName'] != null ? map['stepName'] as String : null,
      details: map['details'] != null ? map['details'] as String : null,
      workoutType: map['workoutType'] != null
          ? WorkoutType.values.byName(map['workoutType'])
          : null,
      estimatedTime:
          map['estimatedTime'] != null ? map['estimatedTime'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeWorkoutStepRequest.fromJson(String source) =>
      ChangeWorkoutStepRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChangeWorkoutStepRequest(stepName: $stepName, details: $details, workoutType: $workoutType, estimatedTime: $estimatedTime)';
  }

  @override
  bool operator ==(covariant ChangeWorkoutStepRequest other) {
    if (identical(this, other)) return true;

    return other.stepName == stepName &&
        other.details == details &&
        other.workoutType == workoutType &&
        other.estimatedTime == estimatedTime;
  }

  @override
  int get hashCode {
    return stepName.hashCode ^
        details.hashCode ^
        workoutType.hashCode ^
        estimatedTime.hashCode;
  }
}
