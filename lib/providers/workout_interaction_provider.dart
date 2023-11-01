import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/workout_likes.dart';

var likesForWorkoutProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, int>(
        (ref, workoutId) => FirebaseFirestore.instance
            .collection(FIRESTORE_WORKOUT_LIKES_COLLECTION)
            .doc('$workoutId')
            .snapshots());

var likesByUserProvider = StreamProvider<List<WorkoutLikes>>((ref) =>
    FirebaseFirestore.instance
        .collection(FIRESTORE_WORKOUT_LIKES_COLLECTION)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => WorkoutLikes(
                  workoutId: int.parse(e.id),
                  likes: List<String>.from(e.data()["likes"]),
                ),
              )
              .toList(),
        ));
