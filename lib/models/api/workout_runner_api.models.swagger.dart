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
