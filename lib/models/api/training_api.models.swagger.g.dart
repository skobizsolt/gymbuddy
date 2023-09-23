// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeWorkoutStepRequest _$ChangeWorkoutStepRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeWorkoutStepRequest(
      stepName: json['stepName'] as String?,
      details: json['details'] as String?,
      workoutType: changeWorkoutStepRequestWorkoutTypeNullableFromJson(
          json['workoutType']),
      estimatedTime: json['estimatedTime'] as int?,
    );

Map<String, dynamic> _$ChangeWorkoutStepRequestToJson(
        ChangeWorkoutStepRequest instance) =>
    <String, dynamic>{
      'stepName': instance.stepName,
      'details': instance.details,
      'workoutType':
          changeWorkoutStepRequestWorkoutTypeToJson(instance.workoutType),
      'estimatedTime': instance.estimatedTime,
    };

WorkoutStepResponse _$WorkoutStepResponseFromJson(Map<String, dynamic> json) =>
    WorkoutStepResponse(
      stepNumber: json['stepNumber'] as int?,
      stepName: json['stepName'] as String?,
      details: json['details'] as String?,
      workoutType:
          workoutStepResponseWorkoutTypeNullableFromJson(json['workoutType']),
      estimatedTime: json['estimatedTime'] as int?,
    );

Map<String, dynamic> _$WorkoutStepResponseToJson(
        WorkoutStepResponse instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'stepName': instance.stepName,
      'details': instance.details,
      'workoutType': workoutStepResponseWorkoutTypeToJson(instance.workoutType),
      'estimatedTime': instance.estimatedTime,
    };

ChangeWorkoutRequest _$ChangeWorkoutRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeWorkoutRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: changeWorkoutRequestCategoryNullableFromJson(json['category']),
      difficulty:
          changeWorkoutRequestDifficultyNullableFromJson(json['difficulty']),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) =>
                  ChangeWorkoutStepRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ChangeWorkoutRequestToJson(
        ChangeWorkoutRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': changeWorkoutRequestCategoryToJson(instance.category),
      'difficulty': changeWorkoutRequestDifficultyToJson(instance.difficulty),
      'steps': instance.steps?.map((e) => e.toJson()).toList(),
    };

GeneralStepDetailsDto _$GeneralStepDetailsDtoFromJson(
        Map<String, dynamic> json) =>
    GeneralStepDetailsDto(
      estimatedTimeInMinutes: json['estimatedTimeInMinutes'] as int?,
      totalSteps: json['totalSteps'] as int?,
    );

Map<String, dynamic> _$GeneralStepDetailsDtoToJson(
        GeneralStepDetailsDto instance) =>
    <String, dynamic>{
      'estimatedTimeInMinutes': instance.estimatedTimeInMinutes,
      'totalSteps': instance.totalSteps,
    };

WorkoutResponse _$WorkoutResponseFromJson(Map<String, dynamic> json) =>
    WorkoutResponse(
      workoutId: json['workoutId'] as int?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      registeredOn: json['registeredOn'] == null
          ? null
          : DateTime.parse(json['registeredOn'] as String),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      category: workoutResponseCategoryNullableFromJson(json['category']),
      difficulty: workoutResponseDifficultyNullableFromJson(json['difficulty']),
      stepDetails: json['stepDetails'] == null
          ? null
          : GeneralStepDetailsDto.fromJson(
              json['stepDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkoutResponseToJson(WorkoutResponse instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'registeredOn': instance.registeredOn?.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
      'category': workoutResponseCategoryToJson(instance.category),
      'difficulty': workoutResponseDifficultyToJson(instance.difficulty),
      'stepDetails': instance.stepDetails?.toJson(),
    };

DetailedWorkoutsResponse _$DetailedWorkoutsResponseFromJson(
        Map<String, dynamic> json) =>
    DetailedWorkoutsResponse(
      workout: json['workout'] == null
          ? null
          : WorkoutResponse.fromJson(json['workout'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) =>
                  WorkoutStepResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DetailedWorkoutsResponseToJson(
        DetailedWorkoutsResponse instance) =>
    <String, dynamic>{
      'workout': instance.workout?.toJson(),
      'steps': instance.steps?.map((e) => e.toJson()).toList(),
    };

WorkoutListResponse _$WorkoutListResponseFromJson(Map<String, dynamic> json) =>
    WorkoutListResponse(
      workouts: (json['workouts'] as List<dynamic>?)
              ?.map((e) => WorkoutResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$WorkoutListResponseToJson(
        WorkoutListResponse instance) =>
    <String, dynamic>{
      'workouts': instance.workouts?.map((e) => e.toJson()).toList(),
    };
