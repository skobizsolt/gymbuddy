import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/firebase_constants.dart';

class WorkoutInteractionService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createLikesDocument(final int workoutId) async {
    return await _getReference(workoutId).set(
      {
        "likes": [],
      },
    );
  }

  Future<void> likeWorkout(final int workoutId) async {
    return await _getReference(workoutId).update(
      {
        "likes": FieldValue.arrayUnion([_auth.currentUser!.uid]),
      },
    );
  }

  unlikeWorkout(final int workoutId) async {
    return await _getReference(workoutId).update(
      {
        "likes": FieldValue.arrayRemove([_auth.currentUser!.uid]),
      },
    );
  }

  deleteLikesDocument(final int workoutId) async {
    return await _getReference(workoutId).delete();
  }

  DocumentReference<Map<String, dynamic>> _getReference(final int workoutId) {
    return _firestore
        .collection(FIRESTORE_WORKOUT_LIKES_COLLECTION)
        .doc('$workoutId');
  }
}
