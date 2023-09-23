import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_request.dart';
import 'package:gymbuddy/temp/temp_workout_details.dart';

class WorkoutService {
  var _api =
      TrainingApi.create(baseUrl: Uri.http(GlobalValues.ANDROID_EMULATOR_URL));

  Future<void> createWorkout(
    BuildContext context,
    ChangeWorkoutRequest workout,
  ) async {
    var request = ChangeWorkoutDto.fromJson(workout.toMap());
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
          builder: (context) => TempWorkoutDetails(
            workout: response.body!.workout!,
            steps: response.body!.steps ?? [],
          ),
        ))
        .whenComplete(() => Navigator.of(context).pop());
  }
}
