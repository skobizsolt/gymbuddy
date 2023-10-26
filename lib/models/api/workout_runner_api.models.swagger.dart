// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'workout_runner_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class PostSessionDetailsDto {
  const PostSessionDetailsDto({
    this.workoutId,
    this.userId,
  });

  factory PostSessionDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PostSessionDetailsDtoFromJson(json);

  static const toJsonFactory = _$PostSessionDetailsDtoToJson;
  Map<String, dynamic> toJson() => _$PostSessionDetailsDtoToJson(this);

  @JsonKey(name: 'workoutId')
  final int? workoutId;
  @JsonKey(name: 'userId')
  final String? userId;
  static const fromJsonFactory = _$PostSessionDetailsDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostSessionDetailsDto &&
            (identical(other.workoutId, workoutId) ||
                const DeepCollectionEquality()
                    .equals(other.workoutId, workoutId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(workoutId) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $PostSessionDetailsDtoExtension on PostSessionDetailsDto {
  PostSessionDetailsDto copyWith({int? workoutId, String? userId}) {
    return PostSessionDetailsDto(
        workoutId: workoutId ?? this.workoutId, userId: userId ?? this.userId);
  }

  PostSessionDetailsDto copyWithWrapped(
      {Wrapped<int?>? workoutId, Wrapped<String?>? userId}) {
    return PostSessionDetailsDto(
        workoutId: (workoutId != null ? workoutId.value : this.workoutId),
        userId: (userId != null ? userId.value : this.userId));
  }
}

@JsonSerializable(explicitToJson: true)
class SessionStartedResponse {
  const SessionStartedResponse({
    this.sessionId,
  });

  factory SessionStartedResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionStartedResponseFromJson(json);

  static const toJsonFactory = _$SessionStartedResponseToJson;
  Map<String, dynamic> toJson() => _$SessionStartedResponseToJson(this);

  @JsonKey(name: 'sessionId')
  final String? sessionId;
  static const fromJsonFactory = _$SessionStartedResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SessionStartedResponse &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sessionId) ^ runtimeType.hashCode;
}

extension $SessionStartedResponseExtension on SessionStartedResponse {
  SessionStartedResponse copyWith({String? sessionId}) {
    return SessionStartedResponse(sessionId: sessionId ?? this.sessionId);
  }

  SessionStartedResponse copyWithWrapped({Wrapped<String?>? sessionId}) {
    return SessionStartedResponse(
        sessionId: (sessionId != null ? sessionId.value : this.sessionId));
  }
}

@JsonSerializable(explicitToJson: true)
class PostRecordDto {
  const PostRecordDto({
    this.workoutId,
    this.stepId,
    this.sessionId,
    this.duration,
  });

  factory PostRecordDto.fromJson(Map<String, dynamic> json) =>
      _$PostRecordDtoFromJson(json);

  static const toJsonFactory = _$PostRecordDtoToJson;
  Map<String, dynamic> toJson() => _$PostRecordDtoToJson(this);

  @JsonKey(name: 'workoutId')
  final int? workoutId;
  @JsonKey(name: 'stepId')
  final int? stepId;
  @JsonKey(name: 'sessionId')
  final String? sessionId;
  @JsonKey(name: 'duration')
  final double? duration;
  static const fromJsonFactory = _$PostRecordDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PostRecordDto &&
            (identical(other.workoutId, workoutId) ||
                const DeepCollectionEquality()
                    .equals(other.workoutId, workoutId)) &&
            (identical(other.stepId, stepId) ||
                const DeepCollectionEquality().equals(other.stepId, stepId)) &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(workoutId) ^
      const DeepCollectionEquality().hash(stepId) ^
      const DeepCollectionEquality().hash(sessionId) ^
      const DeepCollectionEquality().hash(duration) ^
      runtimeType.hashCode;
}

extension $PostRecordDtoExtension on PostRecordDto {
  PostRecordDto copyWith(
      {int? workoutId, int? stepId, String? sessionId, double? duration}) {
    return PostRecordDto(
        workoutId: workoutId ?? this.workoutId,
        stepId: stepId ?? this.stepId,
        sessionId: sessionId ?? this.sessionId,
        duration: duration ?? this.duration);
  }

  PostRecordDto copyWithWrapped(
      {Wrapped<int?>? workoutId,
      Wrapped<int?>? stepId,
      Wrapped<String?>? sessionId,
      Wrapped<double?>? duration}) {
    return PostRecordDto(
        workoutId: (workoutId != null ? workoutId.value : this.workoutId),
        stepId: (stepId != null ? stepId.value : this.stepId),
        sessionId: (sessionId != null ? sessionId.value : this.sessionId),
        duration: (duration != null ? duration.value : this.duration));
  }
}

@JsonSerializable(explicitToJson: true)
class StepRecordResponse {
  const StepRecordResponse({
    this.stepId,
    this.completedAt,
    this.duration,
  });

  factory StepRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$StepRecordResponseFromJson(json);

  static const toJsonFactory = _$StepRecordResponseToJson;
  Map<String, dynamic> toJson() => _$StepRecordResponseToJson(this);

  @JsonKey(name: 'stepId')
  final int? stepId;
  @JsonKey(name: 'completedAt')
  final DateTime? completedAt;
  @JsonKey(name: 'duration')
  final double? duration;
  static const fromJsonFactory = _$StepRecordResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StepRecordResponse &&
            (identical(other.stepId, stepId) ||
                const DeepCollectionEquality().equals(other.stepId, stepId)) &&
            (identical(other.completedAt, completedAt) ||
                const DeepCollectionEquality()
                    .equals(other.completedAt, completedAt)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(stepId) ^
      const DeepCollectionEquality().hash(completedAt) ^
      const DeepCollectionEquality().hash(duration) ^
      runtimeType.hashCode;
}

extension $StepRecordResponseExtension on StepRecordResponse {
  StepRecordResponse copyWith(
      {int? stepId, DateTime? completedAt, double? duration}) {
    return StepRecordResponse(
        stepId: stepId ?? this.stepId,
        completedAt: completedAt ?? this.completedAt,
        duration: duration ?? this.duration);
  }

  StepRecordResponse copyWithWrapped(
      {Wrapped<int?>? stepId,
      Wrapped<DateTime?>? completedAt,
      Wrapped<double?>? duration}) {
    return StepRecordResponse(
        stepId: (stepId != null ? stepId.value : this.stepId),
        completedAt:
            (completedAt != null ? completedAt.value : this.completedAt),
        duration: (duration != null ? duration.value : this.duration));
  }
}

@JsonSerializable(explicitToJson: true)
class SessionActivityResponse {
  const SessionActivityResponse({
    this.sessionId,
    this.workoutId,
    this.workoutName,
    this.difficulty,
    this.category,
    this.startedAt,
    this.completedAt,
    this.completionStatus,
    this.timeToComplete,
    this.completedInSeconds,
  });

  factory SessionActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionActivityResponseFromJson(json);

  static const toJsonFactory = _$SessionActivityResponseToJson;
  Map<String, dynamic> toJson() => _$SessionActivityResponseToJson(this);

  @JsonKey(name: 'sessionId')
  final String? sessionId;
  @JsonKey(name: 'workoutId')
  final int? workoutId;
  @JsonKey(name: 'workoutName')
  final String? workoutName;
  @JsonKey(name: 'difficulty')
  final String? difficulty;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'startedAt')
  final DateTime? startedAt;
  @JsonKey(name: 'completedAt')
  final DateTime? completedAt;
  @JsonKey(name: 'completionStatus')
  final String? completionStatus;
  @JsonKey(name: 'timeToComplete')
  final double? timeToComplete;
  @JsonKey(name: 'completedInSeconds')
  final double? completedInSeconds;
  static const fromJsonFactory = _$SessionActivityResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SessionActivityResponse &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)) &&
            (identical(other.workoutId, workoutId) ||
                const DeepCollectionEquality()
                    .equals(other.workoutId, workoutId)) &&
            (identical(other.workoutName, workoutName) ||
                const DeepCollectionEquality()
                    .equals(other.workoutName, workoutName)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality()
                    .equals(other.difficulty, difficulty)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.startedAt, startedAt) ||
                const DeepCollectionEquality()
                    .equals(other.startedAt, startedAt)) &&
            (identical(other.completedAt, completedAt) ||
                const DeepCollectionEquality()
                    .equals(other.completedAt, completedAt)) &&
            (identical(other.completionStatus, completionStatus) ||
                const DeepCollectionEquality()
                    .equals(other.completionStatus, completionStatus)) &&
            (identical(other.timeToComplete, timeToComplete) ||
                const DeepCollectionEquality()
                    .equals(other.timeToComplete, timeToComplete)) &&
            (identical(other.completedInSeconds, completedInSeconds) ||
                const DeepCollectionEquality()
                    .equals(other.completedInSeconds, completedInSeconds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sessionId) ^
      const DeepCollectionEquality().hash(workoutId) ^
      const DeepCollectionEquality().hash(workoutName) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(startedAt) ^
      const DeepCollectionEquality().hash(completedAt) ^
      const DeepCollectionEquality().hash(completionStatus) ^
      const DeepCollectionEquality().hash(timeToComplete) ^
      const DeepCollectionEquality().hash(completedInSeconds) ^
      runtimeType.hashCode;
}

extension $SessionActivityResponseExtension on SessionActivityResponse {
  SessionActivityResponse copyWith(
      {String? sessionId,
      int? workoutId,
      String? workoutName,
      String? difficulty,
      String? category,
      DateTime? startedAt,
      DateTime? completedAt,
      String? completionStatus,
      double? timeToComplete,
      double? completedInSeconds}) {
    return SessionActivityResponse(
        sessionId: sessionId ?? this.sessionId,
        workoutId: workoutId ?? this.workoutId,
        workoutName: workoutName ?? this.workoutName,
        difficulty: difficulty ?? this.difficulty,
        category: category ?? this.category,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt ?? this.completedAt,
        completionStatus: completionStatus ?? this.completionStatus,
        timeToComplete: timeToComplete ?? this.timeToComplete,
        completedInSeconds: completedInSeconds ?? this.completedInSeconds);
  }

  SessionActivityResponse copyWithWrapped(
      {Wrapped<String?>? sessionId,
      Wrapped<int?>? workoutId,
      Wrapped<String?>? workoutName,
      Wrapped<String?>? difficulty,
      Wrapped<String?>? category,
      Wrapped<DateTime?>? startedAt,
      Wrapped<DateTime?>? completedAt,
      Wrapped<String?>? completionStatus,
      Wrapped<double?>? timeToComplete,
      Wrapped<double?>? completedInSeconds}) {
    return SessionActivityResponse(
        sessionId: (sessionId != null ? sessionId.value : this.sessionId),
        workoutId: (workoutId != null ? workoutId.value : this.workoutId),
        workoutName:
            (workoutName != null ? workoutName.value : this.workoutName),
        difficulty: (difficulty != null ? difficulty.value : this.difficulty),
        category: (category != null ? category.value : this.category),
        startedAt: (startedAt != null ? startedAt.value : this.startedAt),
        completedAt:
            (completedAt != null ? completedAt.value : this.completedAt),
        completionStatus: (completionStatus != null
            ? completionStatus.value
            : this.completionStatus),
        timeToComplete: (timeToComplete != null
            ? timeToComplete.value
            : this.timeToComplete),
        completedInSeconds: (completedInSeconds != null
            ? completedInSeconds.value
            : this.completedInSeconds));
  }
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
