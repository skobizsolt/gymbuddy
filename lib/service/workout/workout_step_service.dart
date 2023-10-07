import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutStepService extends StateNotifier<List<WorkoutStep>> {
  WorkoutStepService() : super([]);

  final _workoutMapper = WorkoutModelMapper();
  final _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<List<WorkoutStep>> getSteps(
      int workoutId, BuildContext context) async {
    var response = await _api.workoutsWorkoutIdStepsGet(workoutId: workoutId);

    ResponseValidator.validateResponse(response, context);

    final workoutSteps = _workoutMapper.toWorkoutSteps(response.body!);
    state = workoutSteps;

    return workoutSteps;
  }

  Future<WorkoutStep> createStep(
      BuildContext context, int workoutId, ChangeWorkoutStepDto newStep) async {
    var response = await _api.workoutsWorkoutIdStepsPost(
      workoutId: workoutId,
      body: ChangeWorkoutStepRequest.fromJson(newStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    var mappedNewStep = _workoutMapper.toWorkoutStep(response.body!);
    state = [...state, mappedNewStep];

    showSucessSnackBar(
        context, "New step (${response.body!.stepNumber}. step) added!");
    return mappedNewStep;
  }

  Future<WorkoutStep> editStep(BuildContext context, int workoutId,
      int stepNumber, ChangeWorkoutStepDto editedStep) async {
    var response = await _api.workoutsWorkoutIdStepsStepNumberPut(
      workoutId: workoutId,
      stepNumber: stepNumber,
      body: ChangeWorkoutStepRequest.fromJson(editedStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    var mappedEditedStep = WorkoutModelMapper().toWorkoutStep(response.body!);
    final updatedStepList = state
        .map(
          (e) => e.stepNumber == mappedEditedStep.stepNumber
              ? mappedEditedStep
              : e,
        )
        .toList();
    state = updatedStepList;

    showSucessSnackBar(
        context, "Training ${response.body!.stepName} changed successfully!");
    return mappedEditedStep;
  }

  Future<void> deleteStep(
      BuildContext context, int workoutId, int stepNumber) async {
    final response = await _api.workoutsWorkoutIdStepsStepNumberDelete(
        workoutId: workoutId, stepNumber: stepNumber);

    ResponseValidator.validateResponse(response, context);

    state = [...state.where((element) => element.stepNumber != stepNumber)];
  }
}
