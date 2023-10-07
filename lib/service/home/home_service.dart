import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/home/home_dto.dart';
import 'package:gymbuddy/screen/workout/displays/workout_by_user.dart';
import 'package:gymbuddy/screen/workout/search_workouts_screen.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';

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

  static Future<void> showMyTrainings(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutsByUser(),
      ),
    );
  }
}
