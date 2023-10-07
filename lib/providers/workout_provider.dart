import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';

var workoutStateProvider = StateNotifierProvider<WorkoutService, List<Workout>>(
    (ref) => WorkoutService());

FutureProvider<List<Workout>> workoutsProvider = FutureProvider(
    (ref) => ref.watch(workoutStateProvider.notifier).getWorkouts());

var workoutByCategoryProvider =
    FutureProvider.family<List<Workout>, WorkoutCategory>(
  (ref, category) => ref.watch(workoutsProvider).hasValue
      ? ref
          .watch(workoutsProvider)
          .value!
          .where((element) => element.category == category)
          .toList()
      : [] as List<Workout>,
);

var workoutByUserProvider = FutureProvider(
  (ref) => ref.watch(workoutsProvider).hasValue
      ? ref
          .watch(workoutsProvider)
          .value!
          .where((element) =>
              element.userId == FirebaseAuth.instance.currentUser!.uid)
          .toList()
      : [] as List<Workout>,
);

var workoutStepProvider =
    StateNotifierProvider<WorkoutStepService, List<WorkoutStep>>(
        (ref) => WorkoutStepService());

var workoutGeneralDetailsProvider =
    StreamProvider.family<WorkoutDetailsResponse, int>((ref, workoutId) {
  ref.watch(workoutStateProvider);
  ref.watch(workoutStepProvider);
  return WorkoutService().getGeneralStepDetails(workoutId);
});
