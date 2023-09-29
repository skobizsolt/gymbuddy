import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutStepService {
  final _workoutMapper = WorkoutModelMapper();
  final _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<List<WorkoutStep>> getSteps(
      int workoutId, BuildContext context) async {
    var response = await _api.workoutsWorkoutIdStepsGet(workoutId: workoutId);

    ResponseValidator.validateResponse(response, context);

    return response.body == null
        ? []
        : _workoutMapper.toWorkoutSteps(response.body!);
  }

  Future<WorkoutStep> editStep(BuildContext context, int workoutId,
      int stepNumber, ChangeWorkoutStepDto editedStep) async {
    var response = await _api.workoutsWorkoutIdStepsStepNumberEditPut(
      workoutId: workoutId,
      stepNumber: stepNumber,
      body: ChangeWorkoutStepRequest.fromJson(editedStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context, "Training ${response.body!.stepName} changed successfully!");
    return WorkoutModelMapper().toWorkoutStep(response.body!);
  }

  Future<void> deleteStep(
      BuildContext context, int workoutId, int stepNumber) async {
    final response = await _api.workoutsWorkoutIdStepsStepNumberDeleteDelete(
        workoutId: workoutId, stepNumber: stepNumber);

    ResponseValidator.validateResponse(response, context);
  }
}
