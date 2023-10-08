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
  final _api = TrainingApi.create(baseUrl: Uri.http(GlobalValues.SERVER_URL));

  Future<List<WorkoutStep>> getSteps(int workoutId) async {
    var response = await _api.workoutsWorkoutIdStepsGet(workoutId: workoutId);

    if (!response.isSuccessful || response.body == null) {
      state = [];
      return state;
    }

    final workoutSteps = _workoutMapper.toWorkoutSteps(response.body!);
    state = workoutSteps;

    return workoutSteps;
  }

  Future<void> createStep(
    BuildContext context,
    int workoutId,
    ChangeWorkoutStepDto? newStep,
  ) async {
    if (newStep == null) {
      return;
    }

    var response = await _api.workoutsWorkoutIdStepsPost(
      workoutId: workoutId,
      body: ChangeWorkoutStepRequest.fromJson(newStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    state = [...state, _workoutMapper.toWorkoutStep(response.body!)];

    showSucessSnackBar(
        context, "New step (${response.body!.stepNumber}. step) added!");
  }

  Future<void> editStep({
    required BuildContext context,
    required int workoutId,
    required int stepNumber,
    required ChangeWorkoutStepDto? editedStep,
  }) async {
    if (editedStep == null) {
      return;
    }

    var response = await _api.workoutsWorkoutIdStepsStepNumberPut(
      workoutId: workoutId,
      stepNumber: stepNumber,
      body: ChangeWorkoutStepRequest.fromJson(editedStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    state = _editWorkoutStepState(
        WorkoutModelMapper().toWorkoutStep(response.body!));

    showSucessSnackBar(
        context, "Training ${response.body!.stepName} changed successfully!");
  }

  Future<void> deleteStep(
      BuildContext context, int workoutId, int stepNumber) async {
    final response = await _api.workoutsWorkoutIdStepsStepNumberDelete(
        workoutId: workoutId, stepNumber: stepNumber);

    ResponseValidator.validateResponse(response, context);

    state = [...state.where((element) => element.stepNumber != stepNumber)];
  }

  List<WorkoutStep> _editWorkoutStepState(WorkoutStep mappedEditedStep) {
    return state
        .map(
          (e) => e.stepNumber == mappedEditedStep.stepNumber
              ? mappedEditedStep
              : e,
        )
        .toList();
  }
}
