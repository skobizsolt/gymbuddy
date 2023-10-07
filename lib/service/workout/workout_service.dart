import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';
import 'package:gymbuddy/service/util/response_validator.dart';

class WorkoutService extends StateNotifier<List<Workout>> {
  WorkoutService() : super([]);

  final _workoutMapper = WorkoutModelMapper();
  final _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<List<Workout>> getWorkouts() async {
    if (state.isNotEmpty) {
      return state;
    }

    final response = await _api.workoutsGet();

    if (!response.isSuccessful && response.body == null) {
      state = [];
      return state;
    }

    var workouts = _workoutMapper.toWorkoutList(response.body!);
    state = workouts;
    return workouts;
  }

  Future<void> createWorkout(
      BuildContext context, ChangeWorkoutDto workout) async {
    var request = CreateWorkoutRequest.fromJson(workout.toAddWorkoutMap());
    var response = await _api.workoutsPost(
        userId: FirebaseAuth.instance.currentUser!.uid, body: request);

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context,
        'Training "${response.body!.workout!.title}"' +
            ' ${workoutCategoryIcon[WorkoutCategory.values.byName(response.body!.workout!.category!.name)]} has created successfully!');

    final newWorkout = _workoutMapper.toWorkout(response.body!.workout!);
    state = [...state, newWorkout];

    await Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => WorkoutDetailsScreen(
            workoutId: GlobalValues.LOCAL_WORKOUT_ID,
          ),
        ))
        .whenComplete(() => Navigator.of(context).pop());
  }

  Stream<WorkoutDetailsResponse> getGeneralStepDetails(
      final int workoutId) async* {
    var response = await _api.workoutsWorkoutIdDetailsGet(workoutId: workoutId);
    yield response.body!;
  }

  Future<Workout> editWorkout(
    final BuildContext context,
    final int workoutId,
    final ChangeWorkoutDto workout,
  ) async {
    var response = await _api.workoutsWorkoutIdPut(
        workoutId: workoutId,
        body: EditWorkoutRequest.fromJson(workout.toEditWorkoutMap()));

    ResponseValidator.validateResponse(response, context);

    showSucessSnackBar(
        context, "Training ${response.body!.title} edited successfully!");

    var editedWorkout = _workoutMapper.toWorkout(response.body!);
    final List<Workout> updatedList = state
        .map(
          (e) => e.workoutId == editedWorkout.workoutId ? editedWorkout : e,
        )
        .toList();
    state = updatedList;

    return editedWorkout;
  }

  Future<void> deleteWorkout(BuildContext context, int workoutId) async {
    final response = await _api.workoutsWorkoutIdDelete(workoutId: workoutId);

    ResponseValidator.validateResponse(response, context);

    state = [...state.where((element) => element.workoutId != workoutId)];

    showSucessSnackBar(context, "Workout deleted successfully!");
  }
}
