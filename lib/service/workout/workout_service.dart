import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutService {
  final _workoutMapper = WorkoutModelMapper();
  final _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<List<Workout>> getWorkouts({WorkoutCategory? category}) async {
    final response = category == null
        ? await _api.workoutsGet()
        : await _api.workoutsGet(
            category: WorkoutsGetCategory.values.byName(category.name));

    return _workoutMapper.toWorkoutList(response.body!);
  }

  getOwnedWorkouts() async {
    final response = await _api.workoutsOwnedGet(
        userId: FirebaseAuth.instance.currentUser!.uid);

    return _workoutMapper.toWorkoutList(response.body!);
  }

  Future<void> createWorkout(
      BuildContext context, ChangeWorkoutDto workout) async {
    var request = CreateWorkoutRequest.fromJson(workout.toAddWorkoutMap());
    var response = await _api.workoutsCreatePost(
        userId: FirebaseAuth.instance.currentUser!.uid, body: request);

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context,
        'Training "${response.body!.workout!.title}"' +
            ' ${workoutCategoryIcon[WorkoutCategory.values.byName(response.body!.workout!.category!.name)]} has created successfully!');

    await Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => WorkoutDetailsScreen(
            workout: _workoutMapper.toWorkout(response.body!.workout!),
            steps: response.body!.steps == null
                ? []
                : _workoutMapper.toWorkoutSteps(response.body!.steps!),
          ),
        ))
        .whenComplete(() => Navigator.of(context).pop());
  }

  Stream<WorkoutDetailsResponse> getGeneralStepDetails(
      final int workoutId, BuildContext context) async* {
    var response =
        await _api.workoutsDataWorkoutIdDetailsGet(workoutId: workoutId);

    ResponseValidator.validateResponse(response, context);
    yield response.body!;
  }

  Future<Workout> editWorkout(
    final BuildContext context,
    final int workoutId,
    final ChangeWorkoutDto workout,
  ) async {
    var response = await _api.workoutsWorkoutIdEditPut(
        workoutId: workoutId,
        body: EditWorkoutRequest.fromJson(workout.toEditWorkoutMap()));

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context, "Training ${response.body!.title} edited successfully!");
    return _workoutMapper.toWorkout(response.body!);
  }

  Future<void> deleteWorkout(BuildContext context, int workoutId) async {
    final response =
        await _api.workoutsWorkoutIdDeleteDelete(workoutId: workoutId);

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(context, "Workout deleted successfully!");
    Navigator.of(context).pop();
  }

  Future<WorkoutStep> createStep(
      BuildContext context, int workoutId, ChangeWorkoutStepDto newStep) async {
    var response = await _api.workoutsWorkoutIdStepsCreatePost(
      workoutId: workoutId,
      body: ChangeWorkoutStepRequest.fromJson(newStep.toMap()),
    );

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context, "New step (${response.body!.stepNumber}. step) added!");
    return _workoutMapper.toWorkoutStep(response.body!);
  }
}
