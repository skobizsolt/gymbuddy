import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/auth/user_service.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';
import 'package:gymbuddy/service/workout/workout_step_media_service.dart';

class WorkoutStepService extends StateNotifier<List<WorkoutStep>> {
  WorkoutStepService() : super([]);

  final _workoutMapper = WorkoutModelMapper();
  final _api = TrainingApi.create(baseUrl: Uri.http(GlobalValues.SERVER_URL));
  final _mediaService = WorkoutStepMediaService();

  Future<List<WorkoutStep>> getSteps(int workoutId) async {
    final token = await UserService.firebaseUserJwtToken;
    var response = await _api.workoutsWorkoutIdStepsGet(
      authorization: token,
      workoutId: workoutId,
    );

    ResponseValidator.validateResponse(response);

    if (response.body == null) {
      state = [];
      return state;
    }

    final workoutSteps = _workoutMapper.toWorkoutSteps(response.body!);
    state = workoutSteps;

    return workoutSteps;
  }

  Future<int?> createStep(
    int workoutId,
    ChangeWorkoutStepDto? newStep,
  ) async {
    if (newStep == null) {
      return null;
    }

    final token = await UserService.firebaseUserJwtToken;
    var response = await _api.workoutsWorkoutIdStepsPost(
      authorization: token,
      workoutId: workoutId,
      body: ChangeWorkoutStepRequest.fromJson(newStep.toMap()),
    );

    ResponseValidator.validateResponse(response);

    state = [...state, _workoutMapper.toWorkoutStep(response.body!)];
    return response.body!.stepId;
  }

  Future<void> editStep({
    required int workoutId,
    required int stepPosition,
    required ChangeWorkoutStepDto? editedStep,
  }) async {
    if (editedStep == null) {
      return;
    }

    final token = await UserService.firebaseUserJwtToken;
    var response = await _api.workoutsWorkoutIdStepsStepIdPut(
      authorization: token,
      workoutId: workoutId,
      stepId: stepPosition,
      body: ChangeWorkoutStepRequest.fromJson(editedStep.toMap()),
    );

    ResponseValidator.validateResponse(response);

    state = _editWorkoutStepState(
        WorkoutModelMapper().toWorkoutStep(response.body!));
  }

  Future<void> deleteStep(
      BuildContext context, int workoutId, int stepId) async {
    final token = await UserService.firebaseUserJwtToken;
    final response = await _api.workoutsWorkoutIdStepsStepIdDelete(
      authorization: token,
      workoutId: workoutId,
      stepId: stepId,
    );

    ResponseValidator.validateResponse(response);

    state = [...state.where((element) => element.stepId != stepId)];
    _mediaService.deleteImagesForStep(workoutId, stepId);
  }

  List<WorkoutStep> _editWorkoutStepState(WorkoutStep mappedEditedStep) {
    return state
        .map(
          (e) => e.stepPosition == mappedEditedStep.stepPosition
              ? mappedEditedStep
              : e,
        )
        .toList();
  }
}
