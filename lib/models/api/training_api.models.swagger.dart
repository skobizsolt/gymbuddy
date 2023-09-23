// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'training_api.enums.swagger.dart' as enums;

part 'training_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class ChangeWorkoutStepDto {
  const ChangeWorkoutStepDto({
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  factory ChangeWorkoutStepDto.fromJson(Map<String, dynamic> json) =>
      _$ChangeWorkoutStepDtoFromJson(json);

  static const toJsonFactory = _$ChangeWorkoutStepDtoToJson;
  Map<String, dynamic> toJson() => _$ChangeWorkoutStepDtoToJson(this);

  @JsonKey(name: 'stepName')
  final String? stepName;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(
    name: 'workoutType',
    toJson: changeWorkoutStepDtoWorkoutTypeToJson,
    fromJson: changeWorkoutStepDtoWorkoutTypeNullableFromJson,
  )
  final enums.ChangeWorkoutStepDtoWorkoutType? workoutType;
  @JsonKey(name: 'estimatedTime')
  final int? estimatedTime;
  static const fromJsonFactory = _$ChangeWorkoutStepDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChangeWorkoutStepDto &&
            (identical(other.stepName, stepName) ||
                const DeepCollectionEquality()
                    .equals(other.stepName, stepName)) &&
            (identical(other.details, details) ||
                const DeepCollectionEquality()
                    .equals(other.details, details)) &&
            (identical(other.workoutType, workoutType) ||
                const DeepCollectionEquality()
                    .equals(other.workoutType, workoutType)) &&
            (identical(other.estimatedTime, estimatedTime) ||
                const DeepCollectionEquality()
                    .equals(other.estimatedTime, estimatedTime)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(stepName) ^
      const DeepCollectionEquality().hash(details) ^
      const DeepCollectionEquality().hash(workoutType) ^
      const DeepCollectionEquality().hash(estimatedTime) ^
      runtimeType.hashCode;
}

extension $ChangeWorkoutStepDtoExtension on ChangeWorkoutStepDto {
  ChangeWorkoutStepDto copyWith(
      {String? stepName,
      String? details,
      enums.ChangeWorkoutStepDtoWorkoutType? workoutType,
      int? estimatedTime}) {
    return ChangeWorkoutStepDto(
        stepName: stepName ?? this.stepName,
        details: details ?? this.details,
        workoutType: workoutType ?? this.workoutType,
        estimatedTime: estimatedTime ?? this.estimatedTime);
  }

  ChangeWorkoutStepDto copyWithWrapped(
      {Wrapped<String?>? stepName,
      Wrapped<String?>? details,
      Wrapped<enums.ChangeWorkoutStepDtoWorkoutType?>? workoutType,
      Wrapped<int?>? estimatedTime}) {
    return ChangeWorkoutStepDto(
        stepName: (stepName != null ? stepName.value : this.stepName),
        details: (details != null ? details.value : this.details),
        workoutType:
            (workoutType != null ? workoutType.value : this.workoutType),
        estimatedTime:
            (estimatedTime != null ? estimatedTime.value : this.estimatedTime));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutStepDto {
  const WorkoutStepDto({
    this.stepNumber,
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  factory WorkoutStepDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutStepDtoFromJson(json);

  static const toJsonFactory = _$WorkoutStepDtoToJson;
  Map<String, dynamic> toJson() => _$WorkoutStepDtoToJson(this);

  @JsonKey(name: 'stepNumber')
  final int? stepNumber;
  @JsonKey(name: 'stepName')
  final String? stepName;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(
    name: 'workoutType',
    toJson: workoutStepDtoWorkoutTypeToJson,
    fromJson: workoutStepDtoWorkoutTypeNullableFromJson,
  )
  final enums.WorkoutStepDtoWorkoutType? workoutType;
  @JsonKey(name: 'estimatedTime')
  final int? estimatedTime;
  static const fromJsonFactory = _$WorkoutStepDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutStepDto &&
            (identical(other.stepNumber, stepNumber) ||
                const DeepCollectionEquality()
                    .equals(other.stepNumber, stepNumber)) &&
            (identical(other.stepName, stepName) ||
                const DeepCollectionEquality()
                    .equals(other.stepName, stepName)) &&
            (identical(other.details, details) ||
                const DeepCollectionEquality()
                    .equals(other.details, details)) &&
            (identical(other.workoutType, workoutType) ||
                const DeepCollectionEquality()
                    .equals(other.workoutType, workoutType)) &&
            (identical(other.estimatedTime, estimatedTime) ||
                const DeepCollectionEquality()
                    .equals(other.estimatedTime, estimatedTime)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(stepNumber) ^
      const DeepCollectionEquality().hash(stepName) ^
      const DeepCollectionEquality().hash(details) ^
      const DeepCollectionEquality().hash(workoutType) ^
      const DeepCollectionEquality().hash(estimatedTime) ^
      runtimeType.hashCode;
}

extension $WorkoutStepDtoExtension on WorkoutStepDto {
  WorkoutStepDto copyWith(
      {int? stepNumber,
      String? stepName,
      String? details,
      enums.WorkoutStepDtoWorkoutType? workoutType,
      int? estimatedTime}) {
    return WorkoutStepDto(
        stepNumber: stepNumber ?? this.stepNumber,
        stepName: stepName ?? this.stepName,
        details: details ?? this.details,
        workoutType: workoutType ?? this.workoutType,
        estimatedTime: estimatedTime ?? this.estimatedTime);
  }

  WorkoutStepDto copyWithWrapped(
      {Wrapped<int?>? stepNumber,
      Wrapped<String?>? stepName,
      Wrapped<String?>? details,
      Wrapped<enums.WorkoutStepDtoWorkoutType?>? workoutType,
      Wrapped<int?>? estimatedTime}) {
    return WorkoutStepDto(
        stepNumber: (stepNumber != null ? stepNumber.value : this.stepNumber),
        stepName: (stepName != null ? stepName.value : this.stepName),
        details: (details != null ? details.value : this.details),
        workoutType:
            (workoutType != null ? workoutType.value : this.workoutType),
        estimatedTime:
            (estimatedTime != null ? estimatedTime.value : this.estimatedTime));
  }
}

@JsonSerializable(explicitToJson: true)
class ChangeWorkoutDto {
  const ChangeWorkoutDto({
    this.title,
    this.description,
    this.category,
    this.difficulty,
    this.steps,
  });

  factory ChangeWorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$ChangeWorkoutDtoFromJson(json);

  static const toJsonFactory = _$ChangeWorkoutDtoToJson;
  Map<String, dynamic> toJson() => _$ChangeWorkoutDtoToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
    name: 'category',
    toJson: changeWorkoutDtoCategoryToJson,
    fromJson: changeWorkoutDtoCategoryNullableFromJson,
  )
  final enums.ChangeWorkoutDtoCategory? category;
  @JsonKey(
    name: 'difficulty',
    toJson: changeWorkoutDtoDifficultyToJson,
    fromJson: changeWorkoutDtoDifficultyNullableFromJson,
  )
  final enums.ChangeWorkoutDtoDifficulty? difficulty;
  @JsonKey(name: 'steps', defaultValue: <ChangeWorkoutStepDto>[])
  final List<ChangeWorkoutStepDto>? steps;
  static const fromJsonFactory = _$ChangeWorkoutDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChangeWorkoutDto &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality()
                    .equals(other.difficulty, difficulty)) &&
            (identical(other.steps, steps) ||
                const DeepCollectionEquality().equals(other.steps, steps)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(steps) ^
      runtimeType.hashCode;
}

extension $ChangeWorkoutDtoExtension on ChangeWorkoutDto {
  ChangeWorkoutDto copyWith(
      {String? title,
      String? description,
      enums.ChangeWorkoutDtoCategory? category,
      enums.ChangeWorkoutDtoDifficulty? difficulty,
      List<ChangeWorkoutStepDto>? steps}) {
    return ChangeWorkoutDto(
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        steps: steps ?? this.steps);
  }

  ChangeWorkoutDto copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<enums.ChangeWorkoutDtoCategory?>? category,
      Wrapped<enums.ChangeWorkoutDtoDifficulty?>? difficulty,
      Wrapped<List<ChangeWorkoutStepDto>?>? steps}) {
    return ChangeWorkoutDto(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        difficulty: (difficulty != null ? difficulty.value : this.difficulty),
        steps: (steps != null ? steps.value : this.steps));
  }
}

@JsonSerializable(explicitToJson: true)
class GeneralStepDetailsDto {
  const GeneralStepDetailsDto({
    this.estimatedTimeInMinutes,
    this.totalSteps,
  });

  factory GeneralStepDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$GeneralStepDetailsDtoFromJson(json);

  static const toJsonFactory = _$GeneralStepDetailsDtoToJson;
  Map<String, dynamic> toJson() => _$GeneralStepDetailsDtoToJson(this);

  @JsonKey(name: 'estimatedTimeInMinutes')
  final int? estimatedTimeInMinutes;
  @JsonKey(name: 'totalSteps')
  final int? totalSteps;
  static const fromJsonFactory = _$GeneralStepDetailsDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GeneralStepDetailsDto &&
            (identical(other.estimatedTimeInMinutes, estimatedTimeInMinutes) ||
                const DeepCollectionEquality().equals(
                    other.estimatedTimeInMinutes, estimatedTimeInMinutes)) &&
            (identical(other.totalSteps, totalSteps) ||
                const DeepCollectionEquality()
                    .equals(other.totalSteps, totalSteps)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(estimatedTimeInMinutes) ^
      const DeepCollectionEquality().hash(totalSteps) ^
      runtimeType.hashCode;
}

extension $GeneralStepDetailsDtoExtension on GeneralStepDetailsDto {
  GeneralStepDetailsDto copyWith(
      {int? estimatedTimeInMinutes, int? totalSteps}) {
    return GeneralStepDetailsDto(
        estimatedTimeInMinutes:
            estimatedTimeInMinutes ?? this.estimatedTimeInMinutes,
        totalSteps: totalSteps ?? this.totalSteps);
  }

  GeneralStepDetailsDto copyWithWrapped(
      {Wrapped<int?>? estimatedTimeInMinutes, Wrapped<int?>? totalSteps}) {
    return GeneralStepDetailsDto(
        estimatedTimeInMinutes: (estimatedTimeInMinutes != null
            ? estimatedTimeInMinutes.value
            : this.estimatedTimeInMinutes),
        totalSteps: (totalSteps != null ? totalSteps.value : this.totalSteps));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutDto {
  const WorkoutDto({
    this.workoutId,
    this.userId,
    this.title,
    this.description,
    this.registeredOn,
    this.lastModified,
    this.category,
    this.difficulty,
    this.stepDetails,
  });

  factory WorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDtoFromJson(json);

  static const toJsonFactory = _$WorkoutDtoToJson;
  Map<String, dynamic> toJson() => _$WorkoutDtoToJson(this);

  @JsonKey(name: 'workoutId')
  final int? workoutId;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'registeredOn')
  final DateTime? registeredOn;
  @JsonKey(name: 'lastModified')
  final DateTime? lastModified;
  @JsonKey(
    name: 'category',
    toJson: workoutDtoCategoryToJson,
    fromJson: workoutDtoCategoryNullableFromJson,
  )
  final enums.WorkoutDtoCategory? category;
  @JsonKey(
    name: 'difficulty',
    toJson: workoutDtoDifficultyToJson,
    fromJson: workoutDtoDifficultyNullableFromJson,
  )
  final enums.WorkoutDtoDifficulty? difficulty;
  @JsonKey(name: 'stepDetails')
  final GeneralStepDetailsDto? stepDetails;
  static const fromJsonFactory = _$WorkoutDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutDto &&
            (identical(other.workoutId, workoutId) ||
                const DeepCollectionEquality()
                    .equals(other.workoutId, workoutId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.registeredOn, registeredOn) ||
                const DeepCollectionEquality()
                    .equals(other.registeredOn, registeredOn)) &&
            (identical(other.lastModified, lastModified) ||
                const DeepCollectionEquality()
                    .equals(other.lastModified, lastModified)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality()
                    .equals(other.difficulty, difficulty)) &&
            (identical(other.stepDetails, stepDetails) ||
                const DeepCollectionEquality()
                    .equals(other.stepDetails, stepDetails)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(workoutId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(registeredOn) ^
      const DeepCollectionEquality().hash(lastModified) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(stepDetails) ^
      runtimeType.hashCode;
}

extension $WorkoutDtoExtension on WorkoutDto {
  WorkoutDto copyWith(
      {int? workoutId,
      String? userId,
      String? title,
      String? description,
      DateTime? registeredOn,
      DateTime? lastModified,
      enums.WorkoutDtoCategory? category,
      enums.WorkoutDtoDifficulty? difficulty,
      GeneralStepDetailsDto? stepDetails}) {
    return WorkoutDto(
        workoutId: workoutId ?? this.workoutId,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        registeredOn: registeredOn ?? this.registeredOn,
        lastModified: lastModified ?? this.lastModified,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        stepDetails: stepDetails ?? this.stepDetails);
  }

  WorkoutDto copyWithWrapped(
      {Wrapped<int?>? workoutId,
      Wrapped<String?>? userId,
      Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<DateTime?>? registeredOn,
      Wrapped<DateTime?>? lastModified,
      Wrapped<enums.WorkoutDtoCategory?>? category,
      Wrapped<enums.WorkoutDtoDifficulty?>? difficulty,
      Wrapped<GeneralStepDetailsDto?>? stepDetails}) {
    return WorkoutDto(
        workoutId: (workoutId != null ? workoutId.value : this.workoutId),
        userId: (userId != null ? userId.value : this.userId),
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        registeredOn:
            (registeredOn != null ? registeredOn.value : this.registeredOn),
        lastModified:
            (lastModified != null ? lastModified.value : this.lastModified),
        category: (category != null ? category.value : this.category),
        difficulty: (difficulty != null ? difficulty.value : this.difficulty),
        stepDetails:
            (stepDetails != null ? stepDetails.value : this.stepDetails));
  }
}

@JsonSerializable(explicitToJson: true)
class DetailedWorkoutsDto {
  const DetailedWorkoutsDto({
    this.workout,
    this.steps,
  });

  factory DetailedWorkoutsDto.fromJson(Map<String, dynamic> json) =>
      _$DetailedWorkoutsDtoFromJson(json);

  static const toJsonFactory = _$DetailedWorkoutsDtoToJson;
  Map<String, dynamic> toJson() => _$DetailedWorkoutsDtoToJson(this);

  @JsonKey(name: 'workout')
  final WorkoutDto? workout;
  @JsonKey(name: 'steps', defaultValue: <WorkoutStepDto>[])
  final List<WorkoutStepDto>? steps;
  static const fromJsonFactory = _$DetailedWorkoutsDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DetailedWorkoutsDto &&
            (identical(other.workout, workout) ||
                const DeepCollectionEquality()
                    .equals(other.workout, workout)) &&
            (identical(other.steps, steps) ||
                const DeepCollectionEquality().equals(other.steps, steps)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(workout) ^
      const DeepCollectionEquality().hash(steps) ^
      runtimeType.hashCode;
}

extension $DetailedWorkoutsDtoExtension on DetailedWorkoutsDto {
  DetailedWorkoutsDto copyWith(
      {WorkoutDto? workout, List<WorkoutStepDto>? steps}) {
    return DetailedWorkoutsDto(
        workout: workout ?? this.workout, steps: steps ?? this.steps);
  }

  DetailedWorkoutsDto copyWithWrapped(
      {Wrapped<WorkoutDto?>? workout, Wrapped<List<WorkoutStepDto>?>? steps}) {
    return DetailedWorkoutsDto(
        workout: (workout != null ? workout.value : this.workout),
        steps: (steps != null ? steps.value : this.steps));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutsDto {
  const WorkoutsDto({
    this.workouts,
  });

  factory WorkoutsDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutsDtoFromJson(json);

  static const toJsonFactory = _$WorkoutsDtoToJson;
  Map<String, dynamic> toJson() => _$WorkoutsDtoToJson(this);

  @JsonKey(name: 'workouts', defaultValue: <WorkoutDto>[])
  final List<WorkoutDto>? workouts;
  static const fromJsonFactory = _$WorkoutsDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutsDto &&
            (identical(other.workouts, workouts) ||
                const DeepCollectionEquality()
                    .equals(other.workouts, workouts)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(workouts) ^ runtimeType.hashCode;
}

extension $WorkoutsDtoExtension on WorkoutsDto {
  WorkoutsDto copyWith({List<WorkoutDto>? workouts}) {
    return WorkoutsDto(workouts: workouts ?? this.workouts);
  }

  WorkoutsDto copyWithWrapped({Wrapped<List<WorkoutDto>?>? workouts}) {
    return WorkoutsDto(
        workouts: (workouts != null ? workouts.value : this.workouts));
  }
}

String? changeWorkoutStepDtoWorkoutTypeToJson(
    enums.ChangeWorkoutStepDtoWorkoutType? changeWorkoutStepDtoWorkoutType) {
  return changeWorkoutStepDtoWorkoutType?.value;
}

enums.ChangeWorkoutStepDtoWorkoutType changeWorkoutStepDtoWorkoutTypeFromJson(
  Object? changeWorkoutStepDtoWorkoutType, [
  enums.ChangeWorkoutStepDtoWorkoutType? defaultValue,
]) {
  return enums.ChangeWorkoutStepDtoWorkoutType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          changeWorkoutStepDtoWorkoutType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ChangeWorkoutStepDtoWorkoutType.swaggerGeneratedUnknown;
}

enums.ChangeWorkoutStepDtoWorkoutType?
    changeWorkoutStepDtoWorkoutTypeNullableFromJson(
  Object? changeWorkoutStepDtoWorkoutType, [
  enums.ChangeWorkoutStepDtoWorkoutType? defaultValue,
]) {
  if (changeWorkoutStepDtoWorkoutType == null) {
    return null;
  }
  return enums.ChangeWorkoutStepDtoWorkoutType.values.firstWhereOrNull(
          (e) => e.value == changeWorkoutStepDtoWorkoutType) ??
      defaultValue;
}

List<String> changeWorkoutStepDtoWorkoutTypeListToJson(
    List<enums.ChangeWorkoutStepDtoWorkoutType>?
        changeWorkoutStepDtoWorkoutType) {
  if (changeWorkoutStepDtoWorkoutType == null) {
    return [];
  }

  return changeWorkoutStepDtoWorkoutType.map((e) => e.value!).toList();
}

List<enums.ChangeWorkoutStepDtoWorkoutType>
    changeWorkoutStepDtoWorkoutTypeListFromJson(
  List? changeWorkoutStepDtoWorkoutType, [
  List<enums.ChangeWorkoutStepDtoWorkoutType>? defaultValue,
]) {
  if (changeWorkoutStepDtoWorkoutType == null) {
    return defaultValue ?? [];
  }

  return changeWorkoutStepDtoWorkoutType
      .map((e) => changeWorkoutStepDtoWorkoutTypeFromJson(e.toString()))
      .toList();
}

List<enums.ChangeWorkoutStepDtoWorkoutType>?
    changeWorkoutStepDtoWorkoutTypeNullableListFromJson(
  List? changeWorkoutStepDtoWorkoutType, [
  List<enums.ChangeWorkoutStepDtoWorkoutType>? defaultValue,
]) {
  if (changeWorkoutStepDtoWorkoutType == null) {
    return defaultValue;
  }

  return changeWorkoutStepDtoWorkoutType
      .map((e) => changeWorkoutStepDtoWorkoutTypeFromJson(e.toString()))
      .toList();
}

String? workoutStepDtoWorkoutTypeToJson(
    enums.WorkoutStepDtoWorkoutType? workoutStepDtoWorkoutType) {
  return workoutStepDtoWorkoutType?.value;
}

enums.WorkoutStepDtoWorkoutType workoutStepDtoWorkoutTypeFromJson(
  Object? workoutStepDtoWorkoutType, [
  enums.WorkoutStepDtoWorkoutType? defaultValue,
]) {
  return enums.WorkoutStepDtoWorkoutType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutStepDtoWorkoutType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutStepDtoWorkoutType.swaggerGeneratedUnknown;
}

enums.WorkoutStepDtoWorkoutType? workoutStepDtoWorkoutTypeNullableFromJson(
  Object? workoutStepDtoWorkoutType, [
  enums.WorkoutStepDtoWorkoutType? defaultValue,
]) {
  if (workoutStepDtoWorkoutType == null) {
    return null;
  }
  return enums.WorkoutStepDtoWorkoutType.values
          .firstWhereOrNull((e) => e.value == workoutStepDtoWorkoutType) ??
      defaultValue;
}

List<String> workoutStepDtoWorkoutTypeListToJson(
    List<enums.WorkoutStepDtoWorkoutType>? workoutStepDtoWorkoutType) {
  if (workoutStepDtoWorkoutType == null) {
    return [];
  }

  return workoutStepDtoWorkoutType.map((e) => e.value!).toList();
}

List<enums.WorkoutStepDtoWorkoutType> workoutStepDtoWorkoutTypeListFromJson(
  List? workoutStepDtoWorkoutType, [
  List<enums.WorkoutStepDtoWorkoutType>? defaultValue,
]) {
  if (workoutStepDtoWorkoutType == null) {
    return defaultValue ?? [];
  }

  return workoutStepDtoWorkoutType
      .map((e) => workoutStepDtoWorkoutTypeFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutStepDtoWorkoutType>?
    workoutStepDtoWorkoutTypeNullableListFromJson(
  List? workoutStepDtoWorkoutType, [
  List<enums.WorkoutStepDtoWorkoutType>? defaultValue,
]) {
  if (workoutStepDtoWorkoutType == null) {
    return defaultValue;
  }

  return workoutStepDtoWorkoutType
      .map((e) => workoutStepDtoWorkoutTypeFromJson(e.toString()))
      .toList();
}

String? changeWorkoutDtoCategoryToJson(
    enums.ChangeWorkoutDtoCategory? changeWorkoutDtoCategory) {
  return changeWorkoutDtoCategory?.value;
}

enums.ChangeWorkoutDtoCategory changeWorkoutDtoCategoryFromJson(
  Object? changeWorkoutDtoCategory, [
  enums.ChangeWorkoutDtoCategory? defaultValue,
]) {
  return enums.ChangeWorkoutDtoCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          changeWorkoutDtoCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ChangeWorkoutDtoCategory.swaggerGeneratedUnknown;
}

enums.ChangeWorkoutDtoCategory? changeWorkoutDtoCategoryNullableFromJson(
  Object? changeWorkoutDtoCategory, [
  enums.ChangeWorkoutDtoCategory? defaultValue,
]) {
  if (changeWorkoutDtoCategory == null) {
    return null;
  }
  return enums.ChangeWorkoutDtoCategory.values
          .firstWhereOrNull((e) => e.value == changeWorkoutDtoCategory) ??
      defaultValue;
}

List<String> changeWorkoutDtoCategoryListToJson(
    List<enums.ChangeWorkoutDtoCategory>? changeWorkoutDtoCategory) {
  if (changeWorkoutDtoCategory == null) {
    return [];
  }

  return changeWorkoutDtoCategory.map((e) => e.value!).toList();
}

List<enums.ChangeWorkoutDtoCategory> changeWorkoutDtoCategoryListFromJson(
  List? changeWorkoutDtoCategory, [
  List<enums.ChangeWorkoutDtoCategory>? defaultValue,
]) {
  if (changeWorkoutDtoCategory == null) {
    return defaultValue ?? [];
  }

  return changeWorkoutDtoCategory
      .map((e) => changeWorkoutDtoCategoryFromJson(e.toString()))
      .toList();
}

List<enums.ChangeWorkoutDtoCategory>?
    changeWorkoutDtoCategoryNullableListFromJson(
  List? changeWorkoutDtoCategory, [
  List<enums.ChangeWorkoutDtoCategory>? defaultValue,
]) {
  if (changeWorkoutDtoCategory == null) {
    return defaultValue;
  }

  return changeWorkoutDtoCategory
      .map((e) => changeWorkoutDtoCategoryFromJson(e.toString()))
      .toList();
}

String? changeWorkoutDtoDifficultyToJson(
    enums.ChangeWorkoutDtoDifficulty? changeWorkoutDtoDifficulty) {
  return changeWorkoutDtoDifficulty?.value;
}

enums.ChangeWorkoutDtoDifficulty changeWorkoutDtoDifficultyFromJson(
  Object? changeWorkoutDtoDifficulty, [
  enums.ChangeWorkoutDtoDifficulty? defaultValue,
]) {
  return enums.ChangeWorkoutDtoDifficulty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          changeWorkoutDtoDifficulty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ChangeWorkoutDtoDifficulty.swaggerGeneratedUnknown;
}

enums.ChangeWorkoutDtoDifficulty? changeWorkoutDtoDifficultyNullableFromJson(
  Object? changeWorkoutDtoDifficulty, [
  enums.ChangeWorkoutDtoDifficulty? defaultValue,
]) {
  if (changeWorkoutDtoDifficulty == null) {
    return null;
  }
  return enums.ChangeWorkoutDtoDifficulty.values
          .firstWhereOrNull((e) => e.value == changeWorkoutDtoDifficulty) ??
      defaultValue;
}

List<String> changeWorkoutDtoDifficultyListToJson(
    List<enums.ChangeWorkoutDtoDifficulty>? changeWorkoutDtoDifficulty) {
  if (changeWorkoutDtoDifficulty == null) {
    return [];
  }

  return changeWorkoutDtoDifficulty.map((e) => e.value!).toList();
}

List<enums.ChangeWorkoutDtoDifficulty> changeWorkoutDtoDifficultyListFromJson(
  List? changeWorkoutDtoDifficulty, [
  List<enums.ChangeWorkoutDtoDifficulty>? defaultValue,
]) {
  if (changeWorkoutDtoDifficulty == null) {
    return defaultValue ?? [];
  }

  return changeWorkoutDtoDifficulty
      .map((e) => changeWorkoutDtoDifficultyFromJson(e.toString()))
      .toList();
}

List<enums.ChangeWorkoutDtoDifficulty>?
    changeWorkoutDtoDifficultyNullableListFromJson(
  List? changeWorkoutDtoDifficulty, [
  List<enums.ChangeWorkoutDtoDifficulty>? defaultValue,
]) {
  if (changeWorkoutDtoDifficulty == null) {
    return defaultValue;
  }

  return changeWorkoutDtoDifficulty
      .map((e) => changeWorkoutDtoDifficultyFromJson(e.toString()))
      .toList();
}

String? workoutDtoCategoryToJson(enums.WorkoutDtoCategory? workoutDtoCategory) {
  return workoutDtoCategory?.value;
}

enums.WorkoutDtoCategory workoutDtoCategoryFromJson(
  Object? workoutDtoCategory, [
  enums.WorkoutDtoCategory? defaultValue,
]) {
  return enums.WorkoutDtoCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutDtoCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutDtoCategory.swaggerGeneratedUnknown;
}

enums.WorkoutDtoCategory? workoutDtoCategoryNullableFromJson(
  Object? workoutDtoCategory, [
  enums.WorkoutDtoCategory? defaultValue,
]) {
  if (workoutDtoCategory == null) {
    return null;
  }
  return enums.WorkoutDtoCategory.values
          .firstWhereOrNull((e) => e.value == workoutDtoCategory) ??
      defaultValue;
}

List<String> workoutDtoCategoryListToJson(
    List<enums.WorkoutDtoCategory>? workoutDtoCategory) {
  if (workoutDtoCategory == null) {
    return [];
  }

  return workoutDtoCategory.map((e) => e.value!).toList();
}

List<enums.WorkoutDtoCategory> workoutDtoCategoryListFromJson(
  List? workoutDtoCategory, [
  List<enums.WorkoutDtoCategory>? defaultValue,
]) {
  if (workoutDtoCategory == null) {
    return defaultValue ?? [];
  }

  return workoutDtoCategory
      .map((e) => workoutDtoCategoryFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutDtoCategory>? workoutDtoCategoryNullableListFromJson(
  List? workoutDtoCategory, [
  List<enums.WorkoutDtoCategory>? defaultValue,
]) {
  if (workoutDtoCategory == null) {
    return defaultValue;
  }

  return workoutDtoCategory
      .map((e) => workoutDtoCategoryFromJson(e.toString()))
      .toList();
}

String? workoutDtoDifficultyToJson(
    enums.WorkoutDtoDifficulty? workoutDtoDifficulty) {
  return workoutDtoDifficulty?.value;
}

enums.WorkoutDtoDifficulty workoutDtoDifficultyFromJson(
  Object? workoutDtoDifficulty, [
  enums.WorkoutDtoDifficulty? defaultValue,
]) {
  return enums.WorkoutDtoDifficulty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutDtoDifficulty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutDtoDifficulty.swaggerGeneratedUnknown;
}

enums.WorkoutDtoDifficulty? workoutDtoDifficultyNullableFromJson(
  Object? workoutDtoDifficulty, [
  enums.WorkoutDtoDifficulty? defaultValue,
]) {
  if (workoutDtoDifficulty == null) {
    return null;
  }
  return enums.WorkoutDtoDifficulty.values
          .firstWhereOrNull((e) => e.value == workoutDtoDifficulty) ??
      defaultValue;
}

List<String> workoutDtoDifficultyListToJson(
    List<enums.WorkoutDtoDifficulty>? workoutDtoDifficulty) {
  if (workoutDtoDifficulty == null) {
    return [];
  }

  return workoutDtoDifficulty.map((e) => e.value!).toList();
}

List<enums.WorkoutDtoDifficulty> workoutDtoDifficultyListFromJson(
  List? workoutDtoDifficulty, [
  List<enums.WorkoutDtoDifficulty>? defaultValue,
]) {
  if (workoutDtoDifficulty == null) {
    return defaultValue ?? [];
  }

  return workoutDtoDifficulty
      .map((e) => workoutDtoDifficultyFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutDtoDifficulty>? workoutDtoDifficultyNullableListFromJson(
  List? workoutDtoDifficulty, [
  List<enums.WorkoutDtoDifficulty>? defaultValue,
]) {
  if (workoutDtoDifficulty == null) {
    return defaultValue;
  }

  return workoutDtoDifficulty
      .map((e) => workoutDtoDifficultyFromJson(e.toString()))
      .toList();
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
