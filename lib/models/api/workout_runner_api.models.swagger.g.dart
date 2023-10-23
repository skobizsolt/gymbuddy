// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_runner_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
