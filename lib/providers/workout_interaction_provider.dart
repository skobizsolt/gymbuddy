import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/firebase_constants.dart';

var likesForWorkoutProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, int>(
        (ref, workoutId) => FirebaseFirestore.instance
            .collection(FIRESTORE_WORKOUT_LIKES_COLLECTION)
            .doc('$workoutId')
            .snapshots());
