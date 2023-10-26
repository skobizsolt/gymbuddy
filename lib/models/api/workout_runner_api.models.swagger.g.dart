// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_runner_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSessionDetailsDto _$PostSessionDetailsDtoFromJson(
        Map<String, dynamic> json) =>
    PostSessionDetailsDto(
      workoutId: json['workoutId'] as int?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$PostSessionDetailsDtoToJson(
        PostSessionDetailsDto instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'userId': instance.userId,
    };

SessionStartedResponse _$SessionStartedResponseFromJson(
        Map<String, dynamic> json) =>
    SessionStartedResponse(
      sessionId: json['sessionId'] as String?,
    );

Map<String, dynamic> _$SessionStartedResponseToJson(
        SessionStartedResponse instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
    };

PostRecordDto _$PostRecordDtoFromJson(Map<String, dynamic> json) =>
    PostRecordDto(
      workoutId: json['workoutId'] as int?,
      stepId: json['stepId'] as int?,
      sessionId: json['sessionId'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PostRecordDtoToJson(PostRecordDto instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'stepId': instance.stepId,
      'sessionId': instance.sessionId,
      'duration': instance.duration,
    };

StepRecordResponse _$StepRecordResponseFromJson(Map<String, dynamic> json) =>
    StepRecordResponse(
      stepId: json['stepId'] as int?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      duration: (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StepRecordResponseToJson(StepRecordResponse instance) =>
    <String, dynamic>{
      'stepId': instance.stepId,
      'completedAt': instance.completedAt?.toIso8601String(),
      'duration': instance.duration,
    };

SessionActivityResponse _$SessionActivityResponseFromJson(
        Map<String, dynamic> json) =>
    SessionActivityResponse(
      sessionId: json['sessionId'] as String?,
      workoutId: json['workoutId'] as int?,
      workoutName: json['workoutName'] as String?,
      difficulty: json['difficulty'] as String?,
      category: json['category'] as String?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      completionStatus: json['completionStatus'] as String?,
      timeToComplete: (json['timeToComplete'] as num?)?.toDouble(),
      completedInSeconds: (json['completedInSeconds'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SessionActivityResponseToJson(
        SessionActivityResponse instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'workoutId': instance.workoutId,
      'workoutName': instance.workoutName,
      'difficulty': instance.difficulty,
      'category': instance.category,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'completionStatus': instance.completionStatus,
      'timeToComplete': instance.timeToComplete,
      'completedInSeconds': instance.completedInSeconds,
    };
