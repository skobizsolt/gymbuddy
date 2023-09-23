import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout.dart';
import 'package:gymbuddy/screen/workout/workout_details_screen.dart';
import 'package:gymbuddy/service/mapper/workout_mapper.dart';

class WorkoutService {
  final _workoutMapper = WorkoutModelMapper();

  var _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<void> createWorkout(
    BuildContext context,
    ChangeWorkoutDto workout,
  ) async {
    var request = ChangeWorkoutRequest.fromJson(workout.toMap());
    var response = await _api.workoutsCreatePost(
        userId: FirebaseAuth.instance.currentUser!.uid, body: request);

    if (!response.isSuccessful) {
      showErrorSnackBar(context,
          "An error occured when creating this training. Please try again later!");
    }

    showSucessSnackBar(
        context,
        'Training "${response.body!.workout!.title}"' +
            ' ${workoutCategoryIcon[WorkoutCategory.values.byName(response.body!.workout!.category!.name)]} has created successfully!');

    await Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => WorkoutDetails(
            workout: _workoutMapper.toWorkout(response.body!.workout!),
            steps: response.body!.steps == null
                ? []
                : _workoutMapper.toWorkoutSteps(response.body!.steps!),
          ),
        ))
        .whenComplete(() => Navigator.of(context).pop());
  }
}
