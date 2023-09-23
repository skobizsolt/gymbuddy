// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gymbuddy/models/workout_step.dart';

class ChangeWorkoutStepDto {
  String? stepName;
  String? details;
  WorkoutType? workoutType;
  int? estimatedTime;
  ChangeWorkoutStepDto({
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  ChangeWorkoutStepDto copyWith({
    String? stepName,
    String? details,
    WorkoutType? workoutType,
    int? estimatedTime,
  }) {
    return ChangeWorkoutStepDto(
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

  factory ChangeWorkoutStepDto.fromMap(Map<String, dynamic> map) {
    return ChangeWorkoutStepDto(
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

  factory ChangeWorkoutStepDto.fromJson(String source) =>
      ChangeWorkoutStepDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChangeWorkoutStepDto(stepName: $stepName, details: $details, workoutType: $workoutType, estimatedTime: $estimatedTime)';
  }

  @override
  bool operator ==(covariant ChangeWorkoutStepDto other) {
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
