// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'training_api.enums.swagger.dart' as enums;

part 'training_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class ChangeWorkoutStepRequest {
  const ChangeWorkoutStepRequest({
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  factory ChangeWorkoutStepRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeWorkoutStepRequestFromJson(json);

  static const toJsonFactory = _$ChangeWorkoutStepRequestToJson;
  Map<String, dynamic> toJson() => _$ChangeWorkoutStepRequestToJson(this);

  @JsonKey(name: 'stepName')
  final String? stepName;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(
    name: 'workoutType',
    toJson: changeWorkoutStepRequestWorkoutTypeToJson,
    fromJson: changeWorkoutStepRequestWorkoutTypeNullableFromJson,
  )
  final enums.ChangeWorkoutStepRequestWorkoutType? workoutType;
  @JsonKey(name: 'estimatedTime')
  final int? estimatedTime;
  static const fromJsonFactory = _$ChangeWorkoutStepRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChangeWorkoutStepRequest &&
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

extension $ChangeWorkoutStepRequestExtension on ChangeWorkoutStepRequest {
  ChangeWorkoutStepRequest copyWith(
      {String? stepName,
      String? details,
      enums.ChangeWorkoutStepRequestWorkoutType? workoutType,
      int? estimatedTime}) {
    return ChangeWorkoutStepRequest(
        stepName: stepName ?? this.stepName,
        details: details ?? this.details,
        workoutType: workoutType ?? this.workoutType,
        estimatedTime: estimatedTime ?? this.estimatedTime);
  }

  ChangeWorkoutStepRequest copyWithWrapped(
      {Wrapped<String?>? stepName,
      Wrapped<String?>? details,
      Wrapped<enums.ChangeWorkoutStepRequestWorkoutType?>? workoutType,
      Wrapped<int?>? estimatedTime}) {
    return ChangeWorkoutStepRequest(
        stepName: (stepName != null ? stepName.value : this.stepName),
        details: (details != null ? details.value : this.details),
        workoutType:
            (workoutType != null ? workoutType.value : this.workoutType),
        estimatedTime:
            (estimatedTime != null ? estimatedTime.value : this.estimatedTime));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutStepResponse {
  const WorkoutStepResponse({
    this.stepNumber,
    this.stepName,
    this.details,
    this.workoutType,
    this.estimatedTime,
  });

  factory WorkoutStepResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutStepResponseFromJson(json);

  static const toJsonFactory = _$WorkoutStepResponseToJson;
  Map<String, dynamic> toJson() => _$WorkoutStepResponseToJson(this);

  @JsonKey(name: 'stepNumber')
  final int? stepNumber;
  @JsonKey(name: 'stepName')
  final String? stepName;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(
    name: 'workoutType',
    toJson: workoutStepResponseWorkoutTypeToJson,
    fromJson: workoutStepResponseWorkoutTypeNullableFromJson,
  )
  final enums.WorkoutStepResponseWorkoutType? workoutType;
  @JsonKey(name: 'estimatedTime')
  final int? estimatedTime;
  static const fromJsonFactory = _$WorkoutStepResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutStepResponse &&
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

extension $WorkoutStepResponseExtension on WorkoutStepResponse {
  WorkoutStepResponse copyWith(
      {int? stepNumber,
      String? stepName,
      String? details,
      enums.WorkoutStepResponseWorkoutType? workoutType,
      int? estimatedTime}) {
    return WorkoutStepResponse(
        stepNumber: stepNumber ?? this.stepNumber,
        stepName: stepName ?? this.stepName,
        details: details ?? this.details,
        workoutType: workoutType ?? this.workoutType,
        estimatedTime: estimatedTime ?? this.estimatedTime);
  }

  WorkoutStepResponse copyWithWrapped(
      {Wrapped<int?>? stepNumber,
      Wrapped<String?>? stepName,
      Wrapped<String?>? details,
      Wrapped<enums.WorkoutStepResponseWorkoutType?>? workoutType,
      Wrapped<int?>? estimatedTime}) {
    return WorkoutStepResponse(
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
class EditWorkoutRequest {
  const EditWorkoutRequest({
    this.title,
    this.description,
    this.category,
    this.difficulty,
  });

  factory EditWorkoutRequest.fromJson(Map<String, dynamic> json) =>
      _$EditWorkoutRequestFromJson(json);

  static const toJsonFactory = _$EditWorkoutRequestToJson;
  Map<String, dynamic> toJson() => _$EditWorkoutRequestToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
    name: 'category',
    toJson: editWorkoutRequestCategoryToJson,
    fromJson: editWorkoutRequestCategoryNullableFromJson,
  )
  final enums.EditWorkoutRequestCategory? category;
  @JsonKey(
    name: 'difficulty',
    toJson: editWorkoutRequestDifficultyToJson,
    fromJson: editWorkoutRequestDifficultyNullableFromJson,
  )
  final enums.EditWorkoutRequestDifficulty? difficulty;
  static const fromJsonFactory = _$EditWorkoutRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EditWorkoutRequest &&
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
                    .equals(other.difficulty, difficulty)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(difficulty) ^
      runtimeType.hashCode;
}

extension $EditWorkoutRequestExtension on EditWorkoutRequest {
  EditWorkoutRequest copyWith(
      {String? title,
      String? description,
      enums.EditWorkoutRequestCategory? category,
      enums.EditWorkoutRequestDifficulty? difficulty}) {
    return EditWorkoutRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty);
  }

  EditWorkoutRequest copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<enums.EditWorkoutRequestCategory?>? category,
      Wrapped<enums.EditWorkoutRequestDifficulty?>? difficulty}) {
    return EditWorkoutRequest(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        difficulty: (difficulty != null ? difficulty.value : this.difficulty));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutResponse {
  const WorkoutResponse({
    this.workoutId,
    this.userId,
    this.title,
    this.description,
    this.registeredOn,
    this.lastModified,
    this.category,
    this.difficulty,
  });

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutResponseFromJson(json);

  static const toJsonFactory = _$WorkoutResponseToJson;
  Map<String, dynamic> toJson() => _$WorkoutResponseToJson(this);

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
    toJson: workoutResponseCategoryToJson,
    fromJson: workoutResponseCategoryNullableFromJson,
  )
  final enums.WorkoutResponseCategory? category;
  @JsonKey(
    name: 'difficulty',
    toJson: workoutResponseDifficultyToJson,
    fromJson: workoutResponseDifficultyNullableFromJson,
  )
  final enums.WorkoutResponseDifficulty? difficulty;
  static const fromJsonFactory = _$WorkoutResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutResponse &&
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
                    .equals(other.difficulty, difficulty)));
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
      runtimeType.hashCode;
}

extension $WorkoutResponseExtension on WorkoutResponse {
  WorkoutResponse copyWith(
      {int? workoutId,
      String? userId,
      String? title,
      String? description,
      DateTime? registeredOn,
      DateTime? lastModified,
      enums.WorkoutResponseCategory? category,
      enums.WorkoutResponseDifficulty? difficulty}) {
    return WorkoutResponse(
        workoutId: workoutId ?? this.workoutId,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        registeredOn: registeredOn ?? this.registeredOn,
        lastModified: lastModified ?? this.lastModified,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty);
  }

  WorkoutResponse copyWithWrapped(
      {Wrapped<int?>? workoutId,
      Wrapped<String?>? userId,
      Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<DateTime?>? registeredOn,
      Wrapped<DateTime?>? lastModified,
      Wrapped<enums.WorkoutResponseCategory?>? category,
      Wrapped<enums.WorkoutResponseDifficulty?>? difficulty}) {
    return WorkoutResponse(
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
        difficulty: (difficulty != null ? difficulty.value : this.difficulty));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutRequest {
  const CreateWorkoutRequest({
    this.title,
    this.description,
    this.category,
    this.difficulty,
    this.steps,
  });

  factory CreateWorkoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutRequestFromJson(json);

  static const toJsonFactory = _$CreateWorkoutRequestToJson;
  Map<String, dynamic> toJson() => _$CreateWorkoutRequestToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
    name: 'category',
    toJson: createWorkoutRequestCategoryToJson,
    fromJson: createWorkoutRequestCategoryNullableFromJson,
  )
  final enums.CreateWorkoutRequestCategory? category;
  @JsonKey(
    name: 'difficulty',
    toJson: createWorkoutRequestDifficultyToJson,
    fromJson: createWorkoutRequestDifficultyNullableFromJson,
  )
  final enums.CreateWorkoutRequestDifficulty? difficulty;
  @JsonKey(name: 'steps', defaultValue: <ChangeWorkoutStepRequest>[])
  final List<ChangeWorkoutStepRequest>? steps;
  static const fromJsonFactory = _$CreateWorkoutRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateWorkoutRequest &&
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

extension $CreateWorkoutRequestExtension on CreateWorkoutRequest {
  CreateWorkoutRequest copyWith(
      {String? title,
      String? description,
      enums.CreateWorkoutRequestCategory? category,
      enums.CreateWorkoutRequestDifficulty? difficulty,
      List<ChangeWorkoutStepRequest>? steps}) {
    return CreateWorkoutRequest(
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        steps: steps ?? this.steps);
  }

  CreateWorkoutRequest copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<enums.CreateWorkoutRequestCategory?>? category,
      Wrapped<enums.CreateWorkoutRequestDifficulty?>? difficulty,
      Wrapped<List<ChangeWorkoutStepRequest>?>? steps}) {
    return CreateWorkoutRequest(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        category: (category != null ? category.value : this.category),
        difficulty: (difficulty != null ? difficulty.value : this.difficulty),
        steps: (steps != null ? steps.value : this.steps));
  }
}

@JsonSerializable(explicitToJson: true)
class DetailedWorkoutsResponse {
  const DetailedWorkoutsResponse({
    this.workout,
    this.steps,
  });

  factory DetailedWorkoutsResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailedWorkoutsResponseFromJson(json);

  static const toJsonFactory = _$DetailedWorkoutsResponseToJson;
  Map<String, dynamic> toJson() => _$DetailedWorkoutsResponseToJson(this);

  @JsonKey(name: 'workout')
  final WorkoutResponse? workout;
  @JsonKey(name: 'steps', defaultValue: <WorkoutStepResponse>[])
  final List<WorkoutStepResponse>? steps;
  static const fromJsonFactory = _$DetailedWorkoutsResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DetailedWorkoutsResponse &&
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

extension $DetailedWorkoutsResponseExtension on DetailedWorkoutsResponse {
  DetailedWorkoutsResponse copyWith(
      {WorkoutResponse? workout, List<WorkoutStepResponse>? steps}) {
    return DetailedWorkoutsResponse(
        workout: workout ?? this.workout, steps: steps ?? this.steps);
  }

  DetailedWorkoutsResponse copyWithWrapped(
      {Wrapped<WorkoutResponse?>? workout,
      Wrapped<List<WorkoutStepResponse>?>? steps}) {
    return DetailedWorkoutsResponse(
        workout: (workout != null ? workout.value : this.workout),
        steps: (steps != null ? steps.value : this.steps));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutListResponse {
  const WorkoutListResponse({
    this.workouts,
  });

  factory WorkoutListResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutListResponseFromJson(json);

  static const toJsonFactory = _$WorkoutListResponseToJson;
  Map<String, dynamic> toJson() => _$WorkoutListResponseToJson(this);

  @JsonKey(name: 'workouts', defaultValue: <WorkoutResponse>[])
  final List<WorkoutResponse>? workouts;
  static const fromJsonFactory = _$WorkoutListResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutListResponse &&
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

extension $WorkoutListResponseExtension on WorkoutListResponse {
  WorkoutListResponse copyWith({List<WorkoutResponse>? workouts}) {
    return WorkoutListResponse(workouts: workouts ?? this.workouts);
  }

  WorkoutListResponse copyWithWrapped(
      {Wrapped<List<WorkoutResponse>?>? workouts}) {
    return WorkoutListResponse(
        workouts: (workouts != null ? workouts.value : this.workouts));
  }
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsResponse {
  const WorkoutDetailsResponse({
    this.estimatedTimeInMinutes,
    this.totalSteps,
  });

  factory WorkoutDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDetailsResponseFromJson(json);

  static const toJsonFactory = _$WorkoutDetailsResponseToJson;
  Map<String, dynamic> toJson() => _$WorkoutDetailsResponseToJson(this);

  @JsonKey(name: 'estimatedTimeInMinutes')
  final int? estimatedTimeInMinutes;
  @JsonKey(name: 'totalSteps')
  final int? totalSteps;
  static const fromJsonFactory = _$WorkoutDetailsResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is WorkoutDetailsResponse &&
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

extension $WorkoutDetailsResponseExtension on WorkoutDetailsResponse {
  WorkoutDetailsResponse copyWith(
      {int? estimatedTimeInMinutes, int? totalSteps}) {
    return WorkoutDetailsResponse(
        estimatedTimeInMinutes:
            estimatedTimeInMinutes ?? this.estimatedTimeInMinutes,
        totalSteps: totalSteps ?? this.totalSteps);
  }

  WorkoutDetailsResponse copyWithWrapped(
      {Wrapped<int?>? estimatedTimeInMinutes, Wrapped<int?>? totalSteps}) {
    return WorkoutDetailsResponse(
        estimatedTimeInMinutes: (estimatedTimeInMinutes != null
            ? estimatedTimeInMinutes.value
            : this.estimatedTimeInMinutes),
        totalSteps: (totalSteps != null ? totalSteps.value : this.totalSteps));
  }
}

String? changeWorkoutStepRequestWorkoutTypeToJson(
    enums.ChangeWorkoutStepRequestWorkoutType?
        changeWorkoutStepRequestWorkoutType) {
  return changeWorkoutStepRequestWorkoutType?.value;
}

enums.ChangeWorkoutStepRequestWorkoutType
    changeWorkoutStepRequestWorkoutTypeFromJson(
  Object? changeWorkoutStepRequestWorkoutType, [
  enums.ChangeWorkoutStepRequestWorkoutType? defaultValue,
]) {
  return enums.ChangeWorkoutStepRequestWorkoutType.values.firstWhereOrNull(
          (e) =>
              e.value.toString().toLowerCase() ==
              changeWorkoutStepRequestWorkoutType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ChangeWorkoutStepRequestWorkoutType.swaggerGeneratedUnknown;
}

enums.ChangeWorkoutStepRequestWorkoutType?
    changeWorkoutStepRequestWorkoutTypeNullableFromJson(
  Object? changeWorkoutStepRequestWorkoutType, [
  enums.ChangeWorkoutStepRequestWorkoutType? defaultValue,
]) {
  if (changeWorkoutStepRequestWorkoutType == null) {
    return null;
  }
  return enums.ChangeWorkoutStepRequestWorkoutType.values.firstWhereOrNull(
          (e) => e.value == changeWorkoutStepRequestWorkoutType) ??
      defaultValue;
}

List<String> changeWorkoutStepRequestWorkoutTypeListToJson(
    List<enums.ChangeWorkoutStepRequestWorkoutType>?
        changeWorkoutStepRequestWorkoutType) {
  if (changeWorkoutStepRequestWorkoutType == null) {
    return [];
  }

  return changeWorkoutStepRequestWorkoutType.map((e) => e.value!).toList();
}

List<enums.ChangeWorkoutStepRequestWorkoutType>
    changeWorkoutStepRequestWorkoutTypeListFromJson(
  List? changeWorkoutStepRequestWorkoutType, [
  List<enums.ChangeWorkoutStepRequestWorkoutType>? defaultValue,
]) {
  if (changeWorkoutStepRequestWorkoutType == null) {
    return defaultValue ?? [];
  }

  return changeWorkoutStepRequestWorkoutType
      .map((e) => changeWorkoutStepRequestWorkoutTypeFromJson(e.toString()))
      .toList();
}

List<enums.ChangeWorkoutStepRequestWorkoutType>?
    changeWorkoutStepRequestWorkoutTypeNullableListFromJson(
  List? changeWorkoutStepRequestWorkoutType, [
  List<enums.ChangeWorkoutStepRequestWorkoutType>? defaultValue,
]) {
  if (changeWorkoutStepRequestWorkoutType == null) {
    return defaultValue;
  }

  return changeWorkoutStepRequestWorkoutType
      .map((e) => changeWorkoutStepRequestWorkoutTypeFromJson(e.toString()))
      .toList();
}

String? workoutStepResponseWorkoutTypeToJson(
    enums.WorkoutStepResponseWorkoutType? workoutStepResponseWorkoutType) {
  return workoutStepResponseWorkoutType?.value;
}

enums.WorkoutStepResponseWorkoutType workoutStepResponseWorkoutTypeFromJson(
  Object? workoutStepResponseWorkoutType, [
  enums.WorkoutStepResponseWorkoutType? defaultValue,
]) {
  return enums.WorkoutStepResponseWorkoutType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutStepResponseWorkoutType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutStepResponseWorkoutType.swaggerGeneratedUnknown;
}

enums.WorkoutStepResponseWorkoutType?
    workoutStepResponseWorkoutTypeNullableFromJson(
  Object? workoutStepResponseWorkoutType, [
  enums.WorkoutStepResponseWorkoutType? defaultValue,
]) {
  if (workoutStepResponseWorkoutType == null) {
    return null;
  }
  return enums.WorkoutStepResponseWorkoutType.values
          .firstWhereOrNull((e) => e.value == workoutStepResponseWorkoutType) ??
      defaultValue;
}

List<String> workoutStepResponseWorkoutTypeListToJson(
    List<enums.WorkoutStepResponseWorkoutType>?
        workoutStepResponseWorkoutType) {
  if (workoutStepResponseWorkoutType == null) {
    return [];
  }

  return workoutStepResponseWorkoutType.map((e) => e.value!).toList();
}

List<enums.WorkoutStepResponseWorkoutType>
    workoutStepResponseWorkoutTypeListFromJson(
  List? workoutStepResponseWorkoutType, [
  List<enums.WorkoutStepResponseWorkoutType>? defaultValue,
]) {
  if (workoutStepResponseWorkoutType == null) {
    return defaultValue ?? [];
  }

  return workoutStepResponseWorkoutType
      .map((e) => workoutStepResponseWorkoutTypeFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutStepResponseWorkoutType>?
    workoutStepResponseWorkoutTypeNullableListFromJson(
  List? workoutStepResponseWorkoutType, [
  List<enums.WorkoutStepResponseWorkoutType>? defaultValue,
]) {
  if (workoutStepResponseWorkoutType == null) {
    return defaultValue;
  }

  return workoutStepResponseWorkoutType
      .map((e) => workoutStepResponseWorkoutTypeFromJson(e.toString()))
      .toList();
}

String? editWorkoutRequestCategoryToJson(
    enums.EditWorkoutRequestCategory? editWorkoutRequestCategory) {
  return editWorkoutRequestCategory?.value;
}

enums.EditWorkoutRequestCategory editWorkoutRequestCategoryFromJson(
  Object? editWorkoutRequestCategory, [
  enums.EditWorkoutRequestCategory? defaultValue,
]) {
  return enums.EditWorkoutRequestCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          editWorkoutRequestCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.EditWorkoutRequestCategory.swaggerGeneratedUnknown;
}

enums.EditWorkoutRequestCategory? editWorkoutRequestCategoryNullableFromJson(
  Object? editWorkoutRequestCategory, [
  enums.EditWorkoutRequestCategory? defaultValue,
]) {
  if (editWorkoutRequestCategory == null) {
    return null;
  }
  return enums.EditWorkoutRequestCategory.values
          .firstWhereOrNull((e) => e.value == editWorkoutRequestCategory) ??
      defaultValue;
}

List<String> editWorkoutRequestCategoryListToJson(
    List<enums.EditWorkoutRequestCategory>? editWorkoutRequestCategory) {
  if (editWorkoutRequestCategory == null) {
    return [];
  }

  return editWorkoutRequestCategory.map((e) => e.value!).toList();
}

List<enums.EditWorkoutRequestCategory> editWorkoutRequestCategoryListFromJson(
  List? editWorkoutRequestCategory, [
  List<enums.EditWorkoutRequestCategory>? defaultValue,
]) {
  if (editWorkoutRequestCategory == null) {
    return defaultValue ?? [];
  }

  return editWorkoutRequestCategory
      .map((e) => editWorkoutRequestCategoryFromJson(e.toString()))
      .toList();
}

List<enums.EditWorkoutRequestCategory>?
    editWorkoutRequestCategoryNullableListFromJson(
  List? editWorkoutRequestCategory, [
  List<enums.EditWorkoutRequestCategory>? defaultValue,
]) {
  if (editWorkoutRequestCategory == null) {
    return defaultValue;
  }

  return editWorkoutRequestCategory
      .map((e) => editWorkoutRequestCategoryFromJson(e.toString()))
      .toList();
}

String? editWorkoutRequestDifficultyToJson(
    enums.EditWorkoutRequestDifficulty? editWorkoutRequestDifficulty) {
  return editWorkoutRequestDifficulty?.value;
}

enums.EditWorkoutRequestDifficulty editWorkoutRequestDifficultyFromJson(
  Object? editWorkoutRequestDifficulty, [
  enums.EditWorkoutRequestDifficulty? defaultValue,
]) {
  return enums.EditWorkoutRequestDifficulty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          editWorkoutRequestDifficulty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.EditWorkoutRequestDifficulty.swaggerGeneratedUnknown;
}

enums.EditWorkoutRequestDifficulty?
    editWorkoutRequestDifficultyNullableFromJson(
  Object? editWorkoutRequestDifficulty, [
  enums.EditWorkoutRequestDifficulty? defaultValue,
]) {
  if (editWorkoutRequestDifficulty == null) {
    return null;
  }
  return enums.EditWorkoutRequestDifficulty.values
          .firstWhereOrNull((e) => e.value == editWorkoutRequestDifficulty) ??
      defaultValue;
}

List<String> editWorkoutRequestDifficultyListToJson(
    List<enums.EditWorkoutRequestDifficulty>? editWorkoutRequestDifficulty) {
  if (editWorkoutRequestDifficulty == null) {
    return [];
  }

  return editWorkoutRequestDifficulty.map((e) => e.value!).toList();
}

List<enums.EditWorkoutRequestDifficulty>
    editWorkoutRequestDifficultyListFromJson(
  List? editWorkoutRequestDifficulty, [
  List<enums.EditWorkoutRequestDifficulty>? defaultValue,
]) {
  if (editWorkoutRequestDifficulty == null) {
    return defaultValue ?? [];
  }

  return editWorkoutRequestDifficulty
      .map((e) => editWorkoutRequestDifficultyFromJson(e.toString()))
      .toList();
}

List<enums.EditWorkoutRequestDifficulty>?
    editWorkoutRequestDifficultyNullableListFromJson(
  List? editWorkoutRequestDifficulty, [
  List<enums.EditWorkoutRequestDifficulty>? defaultValue,
]) {
  if (editWorkoutRequestDifficulty == null) {
    return defaultValue;
  }

  return editWorkoutRequestDifficulty
      .map((e) => editWorkoutRequestDifficultyFromJson(e.toString()))
      .toList();
}

String? workoutResponseCategoryToJson(
    enums.WorkoutResponseCategory? workoutResponseCategory) {
  return workoutResponseCategory?.value;
}

enums.WorkoutResponseCategory workoutResponseCategoryFromJson(
  Object? workoutResponseCategory, [
  enums.WorkoutResponseCategory? defaultValue,
]) {
  return enums.WorkoutResponseCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutResponseCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutResponseCategory.swaggerGeneratedUnknown;
}

enums.WorkoutResponseCategory? workoutResponseCategoryNullableFromJson(
  Object? workoutResponseCategory, [
  enums.WorkoutResponseCategory? defaultValue,
]) {
  if (workoutResponseCategory == null) {
    return null;
  }
  return enums.WorkoutResponseCategory.values
          .firstWhereOrNull((e) => e.value == workoutResponseCategory) ??
      defaultValue;
}

List<String> workoutResponseCategoryListToJson(
    List<enums.WorkoutResponseCategory>? workoutResponseCategory) {
  if (workoutResponseCategory == null) {
    return [];
  }

  return workoutResponseCategory.map((e) => e.value!).toList();
}

List<enums.WorkoutResponseCategory> workoutResponseCategoryListFromJson(
  List? workoutResponseCategory, [
  List<enums.WorkoutResponseCategory>? defaultValue,
]) {
  if (workoutResponseCategory == null) {
    return defaultValue ?? [];
  }

  return workoutResponseCategory
      .map((e) => workoutResponseCategoryFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutResponseCategory>?
    workoutResponseCategoryNullableListFromJson(
  List? workoutResponseCategory, [
  List<enums.WorkoutResponseCategory>? defaultValue,
]) {
  if (workoutResponseCategory == null) {
    return defaultValue;
  }

  return workoutResponseCategory
      .map((e) => workoutResponseCategoryFromJson(e.toString()))
      .toList();
}

String? workoutResponseDifficultyToJson(
    enums.WorkoutResponseDifficulty? workoutResponseDifficulty) {
  return workoutResponseDifficulty?.value;
}

enums.WorkoutResponseDifficulty workoutResponseDifficultyFromJson(
  Object? workoutResponseDifficulty, [
  enums.WorkoutResponseDifficulty? defaultValue,
]) {
  return enums.WorkoutResponseDifficulty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutResponseDifficulty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutResponseDifficulty.swaggerGeneratedUnknown;
}

enums.WorkoutResponseDifficulty? workoutResponseDifficultyNullableFromJson(
  Object? workoutResponseDifficulty, [
  enums.WorkoutResponseDifficulty? defaultValue,
]) {
  if (workoutResponseDifficulty == null) {
    return null;
  }
  return enums.WorkoutResponseDifficulty.values
          .firstWhereOrNull((e) => e.value == workoutResponseDifficulty) ??
      defaultValue;
}

List<String> workoutResponseDifficultyListToJson(
    List<enums.WorkoutResponseDifficulty>? workoutResponseDifficulty) {
  if (workoutResponseDifficulty == null) {
    return [];
  }

  return workoutResponseDifficulty.map((e) => e.value!).toList();
}

List<enums.WorkoutResponseDifficulty> workoutResponseDifficultyListFromJson(
  List? workoutResponseDifficulty, [
  List<enums.WorkoutResponseDifficulty>? defaultValue,
]) {
  if (workoutResponseDifficulty == null) {
    return defaultValue ?? [];
  }

  return workoutResponseDifficulty
      .map((e) => workoutResponseDifficultyFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutResponseDifficulty>?
    workoutResponseDifficultyNullableListFromJson(
  List? workoutResponseDifficulty, [
  List<enums.WorkoutResponseDifficulty>? defaultValue,
]) {
  if (workoutResponseDifficulty == null) {
    return defaultValue;
  }

  return workoutResponseDifficulty
      .map((e) => workoutResponseDifficultyFromJson(e.toString()))
      .toList();
}

String? createWorkoutRequestCategoryToJson(
    enums.CreateWorkoutRequestCategory? createWorkoutRequestCategory) {
  return createWorkoutRequestCategory?.value;
}

enums.CreateWorkoutRequestCategory createWorkoutRequestCategoryFromJson(
  Object? createWorkoutRequestCategory, [
  enums.CreateWorkoutRequestCategory? defaultValue,
]) {
  return enums.CreateWorkoutRequestCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          createWorkoutRequestCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.CreateWorkoutRequestCategory.swaggerGeneratedUnknown;
}

enums.CreateWorkoutRequestCategory?
    createWorkoutRequestCategoryNullableFromJson(
  Object? createWorkoutRequestCategory, [
  enums.CreateWorkoutRequestCategory? defaultValue,
]) {
  if (createWorkoutRequestCategory == null) {
    return null;
  }
  return enums.CreateWorkoutRequestCategory.values
          .firstWhereOrNull((e) => e.value == createWorkoutRequestCategory) ??
      defaultValue;
}

List<String> createWorkoutRequestCategoryListToJson(
    List<enums.CreateWorkoutRequestCategory>? createWorkoutRequestCategory) {
  if (createWorkoutRequestCategory == null) {
    return [];
  }

  return createWorkoutRequestCategory.map((e) => e.value!).toList();
}

List<enums.CreateWorkoutRequestCategory>
    createWorkoutRequestCategoryListFromJson(
  List? createWorkoutRequestCategory, [
  List<enums.CreateWorkoutRequestCategory>? defaultValue,
]) {
  if (createWorkoutRequestCategory == null) {
    return defaultValue ?? [];
  }

  return createWorkoutRequestCategory
      .map((e) => createWorkoutRequestCategoryFromJson(e.toString()))
      .toList();
}

List<enums.CreateWorkoutRequestCategory>?
    createWorkoutRequestCategoryNullableListFromJson(
  List? createWorkoutRequestCategory, [
  List<enums.CreateWorkoutRequestCategory>? defaultValue,
]) {
  if (createWorkoutRequestCategory == null) {
    return defaultValue;
  }

  return createWorkoutRequestCategory
      .map((e) => createWorkoutRequestCategoryFromJson(e.toString()))
      .toList();
}

String? createWorkoutRequestDifficultyToJson(
    enums.CreateWorkoutRequestDifficulty? createWorkoutRequestDifficulty) {
  return createWorkoutRequestDifficulty?.value;
}

enums.CreateWorkoutRequestDifficulty createWorkoutRequestDifficultyFromJson(
  Object? createWorkoutRequestDifficulty, [
  enums.CreateWorkoutRequestDifficulty? defaultValue,
]) {
  return enums.CreateWorkoutRequestDifficulty.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          createWorkoutRequestDifficulty?.toString().toLowerCase()) ??
      defaultValue ??
      enums.CreateWorkoutRequestDifficulty.swaggerGeneratedUnknown;
}

enums.CreateWorkoutRequestDifficulty?
    createWorkoutRequestDifficultyNullableFromJson(
  Object? createWorkoutRequestDifficulty, [
  enums.CreateWorkoutRequestDifficulty? defaultValue,
]) {
  if (createWorkoutRequestDifficulty == null) {
    return null;
  }
  return enums.CreateWorkoutRequestDifficulty.values
          .firstWhereOrNull((e) => e.value == createWorkoutRequestDifficulty) ??
      defaultValue;
}

List<String> createWorkoutRequestDifficultyListToJson(
    List<enums.CreateWorkoutRequestDifficulty>?
        createWorkoutRequestDifficulty) {
  if (createWorkoutRequestDifficulty == null) {
    return [];
  }

  return createWorkoutRequestDifficulty.map((e) => e.value!).toList();
}

List<enums.CreateWorkoutRequestDifficulty>
    createWorkoutRequestDifficultyListFromJson(
  List? createWorkoutRequestDifficulty, [
  List<enums.CreateWorkoutRequestDifficulty>? defaultValue,
]) {
  if (createWorkoutRequestDifficulty == null) {
    return defaultValue ?? [];
  }

  return createWorkoutRequestDifficulty
      .map((e) => createWorkoutRequestDifficultyFromJson(e.toString()))
      .toList();
}

List<enums.CreateWorkoutRequestDifficulty>?
    createWorkoutRequestDifficultyNullableListFromJson(
  List? createWorkoutRequestDifficulty, [
  List<enums.CreateWorkoutRequestDifficulty>? defaultValue,
]) {
  if (createWorkoutRequestDifficulty == null) {
    return defaultValue;
  }

  return createWorkoutRequestDifficulty
      .map((e) => createWorkoutRequestDifficultyFromJson(e.toString()))
      .toList();
}

String? workoutsGetCategoryToJson(
    enums.WorkoutsGetCategory? workoutsGetCategory) {
  return workoutsGetCategory?.value;
}

enums.WorkoutsGetCategory workoutsGetCategoryFromJson(
  Object? workoutsGetCategory, [
  enums.WorkoutsGetCategory? defaultValue,
]) {
  return enums.WorkoutsGetCategory.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          workoutsGetCategory?.toString().toLowerCase()) ??
      defaultValue ??
      enums.WorkoutsGetCategory.swaggerGeneratedUnknown;
}

enums.WorkoutsGetCategory? workoutsGetCategoryNullableFromJson(
  Object? workoutsGetCategory, [
  enums.WorkoutsGetCategory? defaultValue,
]) {
  if (workoutsGetCategory == null) {
    return null;
  }
  return enums.WorkoutsGetCategory.values
          .firstWhereOrNull((e) => e.value == workoutsGetCategory) ??
      defaultValue;
}

List<String> workoutsGetCategoryListToJson(
    List<enums.WorkoutsGetCategory>? workoutsGetCategory) {
  if (workoutsGetCategory == null) {
    return [];
  }

  return workoutsGetCategory.map((e) => e.value!).toList();
}

List<enums.WorkoutsGetCategory> workoutsGetCategoryListFromJson(
  List? workoutsGetCategory, [
  List<enums.WorkoutsGetCategory>? defaultValue,
]) {
  if (workoutsGetCategory == null) {
    return defaultValue ?? [];
  }

  return workoutsGetCategory
      .map((e) => workoutsGetCategoryFromJson(e.toString()))
      .toList();
}

List<enums.WorkoutsGetCategory>? workoutsGetCategoryNullableListFromJson(
  List? workoutsGetCategory, [
  List<enums.WorkoutsGetCategory>? defaultValue,
]) {
  if (workoutsGetCategory == null) {
    return defaultValue;
  }

  return workoutsGetCategory
      .map((e) => workoutsGetCategoryFromJson(e.toString()))
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
