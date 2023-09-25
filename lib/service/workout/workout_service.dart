import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutService {
  final _workoutMapper = WorkoutModelMapper();
  final _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<List<Workout>> getWorkouts() async {
    final response = await _api.workoutsGet();

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

  Future<WorkoutResponse> editWorkout(
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
    Navigator.of(context).pop();
    return response.body!;
  }
}
