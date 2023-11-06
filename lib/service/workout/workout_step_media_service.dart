import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:uuid/uuid.dart';

class WorkoutStepMediaService {
  static const IMAGE_URLS = 'imageUrls';

  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  // FIREBASE STORAGE METHODS
  void saveImages({
    required final List<File> images,
    required final int workoutId,
    required final int stepId,
    required final CrudType crudType,
  }) async {
    // If no data provided, a new document is created to add future steps
    if (images.isEmpty && CrudType.add == crudType) {
      _getDatabaseRef(workoutId, stepId).set({IMAGE_URLS: []});
      return;
    }
    final List<String> imageUrls = [];
    await Future.wait(
      images.map(
        (image) => _saveImage(
          image: image,
          workoutId: workoutId,
          stepId: stepId,
        ).then(imageUrls.add),
      ),
    );

    await _addImageUrlsToFirestore(imageUrls, workoutId, stepId, crudType);
  }

  Future<String> _saveImage({
    required final File image,
    required final int workoutId,
    required final int stepId,
  }) async {
    var storageRef =
        _getStorageRef(workoutId, stepId).child('${const Uuid().v4()}.png');
    await storageRef.putFile(image);
    var url = await storageRef.getDownloadURL();
    return url;
  }

  Future<void> deleteImagesForStep(
      final int workoutId, final int stepId) async {
    var storageRef = _getStorageRef(workoutId, stepId);
    try {
      await storageRef.listAll().then(
            (results) => Future.wait(
              results.items.map(
                (item) => item.delete(),
              ),
            ),
          );
    } on Exception {
      print("No workout image at Workout $workoutId step $stepId");
    } finally {
      _deleteImageUrlsFromFirestore(workoutId, stepId);
    }
  }

  Future<void> deleteImagesForWorkout(
      final int workoutId, final List<int> stepIds) async {
    stepIds.forEach((stepId) {
      deleteImagesForStep(workoutId, stepId);
    });
  }

  Future<void> deleteImage({
    required final String url,
    required final int workoutId,
    required final int stepId,
  }) async {
    var storageRef = _storage.refFromURL(url);
    await storageRef
        .delete()
        .then((value) => _deleteImageUrlFromFirestore(url, workoutId, stepId));
  }

  // FIREBASE FIRESTORE METHODS
  Stream<List<String>> getImageUrls(WorkoutIds ids) {
    return FirebaseFirestore.instance
        .collection(FIRESTORE_WORKOUT_COLLECTION)
        .doc('${ids.workoutId}')
        .collection(FIRESTORE_WORKOUT_MEDIA_SUBCOLLECTION)
        .doc('${ids.stepId}')
        .snapshots()
        .map((event) => List<String>.from(
            event.data()![WorkoutStepMediaService.IMAGE_URLS]));
  }

  _deleteImageUrlsFromFirestore(final int workoutId, final int stepId) async {
    return await _getDatabaseRef(workoutId, stepId).delete();
  }

  _addImageUrlsToFirestore(final List<String> urls, final int workoutId,
      final int stepId, final CrudType crudType) async {
    switch (crudType) {
      case CrudType.add:
        await _getDatabaseRef(workoutId, stepId).set(
          {
            IMAGE_URLS: urls,
          },
        );
        break;
      case CrudType.edit:
        await _getDatabaseRef(workoutId, stepId).update({
          IMAGE_URLS: FieldValue.arrayUnion(urls),
        });
        break;
      default:
        break;
    }
  }

  _deleteImageUrlFromFirestore(
      final String url, final int workoutId, final int stepId) async {
    return await _getDatabaseRef(workoutId, stepId).update(
      {
        IMAGE_URLS: FieldValue.arrayRemove([url]),
      },
    );
  }

  Reference _getStorageRef(final int workoutId, final int stepId) {
    return _storage
        .ref()
        .child(FIREBASE_STORAGE_WORKOUT_IMAGES)
        .child('$workoutId')
        .child('$stepId');
  }

  DocumentReference<Map<String, dynamic>> _getDatabaseRef(
      final int workoutId, final int stepId) {
    return _firestore
        .collection(FIRESTORE_WORKOUT_COLLECTION)
        .doc('$workoutId')
        .collection(FIRESTORE_WORKOUT_MEDIA_SUBCOLLECTION)
        .doc('$stepId');
  }
}
