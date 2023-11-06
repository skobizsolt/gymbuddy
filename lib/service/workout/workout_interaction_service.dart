import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbuddy/global/firebase_constants.dart';

class WorkoutInteractionService {
  static const LIKES_LIST = "likes";
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createLikesDocument(final int workoutId) async {
    return await _getReference(workoutId).set(
      {
        LIKES_LIST: [],
      },
    );
  }

  Future<void> likeWorkout(final int workoutId) async {
    return await _getReference(workoutId).update(
      {
        LIKES_LIST: FieldValue.arrayUnion([_auth.currentUser!.uid]),
      },
    );
  }

  unlikeWorkout(final int workoutId) async {
    return await _getReference(workoutId).update(
      {
        LIKES_LIST: FieldValue.arrayRemove([_auth.currentUser!.uid]),
      },
    );
  }

  deleteLikesDocument(final int workoutId) async {
    return await _getReference(workoutId).delete();
  }

  DocumentReference<Map<String, dynamic>> _getReference(final int workoutId) {
    return _firestore
        .collection(FIRESTORE_WORKOUT_COLLECTION)
        .doc('$workoutId');
  }
}
