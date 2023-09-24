import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/home/home_dto.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/search_workouts_screen.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';

class HomeService {
  Future<HomeDto> get homeData async {
    return await FirebaseFirestore.instance
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) => HomeDto(
            firstName: value.data()!["first_name"],
          ).copyWith(
            profileImageUrl: value.data()!["image_url"] ?? null,
          ),
        );
  }

  static void searchWorkouts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchWorkoutsScreen(),
      ),
    );
  }

  static void addNewTraining(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutManager(
          type: CrudType.add,
        ),
      ),
    );
  }

  static void showMyTrainings(BuildContext context, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutsScreen(
          title: "My trainings",
          workouts: _loadMyWorkouts(ref),
        ),
      ),
    );
  }

  static List<Workout> _loadMyWorkouts(WidgetRef ref) {
    final trainings = ref.read(workoutProvider);
    if (!trainings.hasValue) {
      return [];
    }
    return trainings.value!
        .where((element) =>
            element.userId == FirebaseAuth.instance.currentUser!.uid)
        .toList();
  }
}
