// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeWorkoutStepDto _$ChangeWorkoutStepDtoFromJson(
        Map<String, dynamic> json) =>
    ChangeWorkoutStepDto(
      stepName: json['stepName'] as String?,
      details: json['details'] as String?,
      workoutType:
          changeWorkoutStepDtoWorkoutTypeNullableFromJson(json['workoutType']),
      estimatedTime: json['estimatedTime'] as int?,
    );

Map<String, dynamic> _$ChangeWorkoutStepDtoToJson(
        ChangeWorkoutStepDto instance) =>
    <String, dynamic>{
      'stepName': instance.stepName,
      'details': instance.details,
      'workoutType':
          changeWorkoutStepDtoWorkoutTypeToJson(instance.workoutType),
      'estimatedTime': instance.estimatedTime,
    };

WorkoutStepDto _$WorkoutStepDtoFromJson(Map<String, dynamic> json) =>
    WorkoutStepDto(
      stepNumber: json['stepNumber'] as int?,
      stepName: json['stepName'] as String?,
      details: json['details'] as String?,
      workoutType:
          workoutStepDtoWorkoutTypeNullableFromJson(json['workoutType']),
      estimatedTime: json['estimatedTime'] as int?,
    );

Map<String, dynamic> _$WorkoutStepDtoToJson(WorkoutStepDto instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'stepName': instance.stepName,
      'details': instance.details,
      'workoutType': workoutStepDtoWorkoutTypeToJson(instance.workoutType),
      'estimatedTime': instance.estimatedTime,
    };

ChangeWorkoutDto _$ChangeWorkoutDtoFromJson(Map<String, dynamic> json) =>
    ChangeWorkoutDto(
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: changeWorkoutDtoCategoryNullableFromJson(json['category']),
      difficulty:
          changeWorkoutDtoDifficultyNullableFromJson(json['difficulty']),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) =>
                  ChangeWorkoutStepDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ChangeWorkoutDtoToJson(ChangeWorkoutDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': changeWorkoutDtoCategoryToJson(instance.category),
      'difficulty': changeWorkoutDtoDifficultyToJson(instance.difficulty),
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

WorkoutDto _$WorkoutDtoFromJson(Map<String, dynamic> json) => WorkoutDto(
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
      category: workoutDtoCategoryNullableFromJson(json['category']),
      difficulty: workoutDtoDifficultyNullableFromJson(json['difficulty']),
      stepDetails: json['stepDetails'] == null
          ? null
          : GeneralStepDetailsDto.fromJson(
              json['stepDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkoutDtoToJson(WorkoutDto instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'registeredOn': instance.registeredOn?.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
      'category': workoutDtoCategoryToJson(instance.category),
      'difficulty': workoutDtoDifficultyToJson(instance.difficulty),
      'stepDetails': instance.stepDetails?.toJson(),
    };

DetailedWorkoutsDto _$DetailedWorkoutsDtoFromJson(Map<String, dynamic> json) =>
    DetailedWorkoutsDto(
      workout: json['workout'] == null
          ? null
          : WorkoutDto.fromJson(json['workout'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => WorkoutStepDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DetailedWorkoutsDtoToJson(
        DetailedWorkoutsDto instance) =>
    <String, dynamic>{
      'workout': instance.workout?.toJson(),
      'steps': instance.steps?.map((e) => e.toJson()).toList(),
    };

WorkoutsDto _$WorkoutsDtoFromJson(Map<String, dynamic> json) => WorkoutsDto(
      workouts: (json['workouts'] as List<dynamic>?)
              ?.map((e) => WorkoutDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$WorkoutsDtoToJson(WorkoutsDto instance) =>
    <String, dynamic>{
      'workouts': instance.workouts?.map((e) => e.toJson()).toList(),
    };
