import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gymbuddy/global/firebase_constants.dart';
import 'package:gymbuddy/models/workout_image.dart';
import 'package:uuid/uuid.dart';

class WorkoutStepMediaService {
  final _storage = FirebaseStorage.instance;

  void saveImages(final List<WorkoutImage> images, final int workoutId,
      final int stepId) async {
    await Future.wait(
      images.map(
        (image) => saveImage(image.file, workoutId, stepId),
      ),
    );
  }

  Future<void> saveImage(
      final File image, final int workoutId, final int stepId) async {
    var storageRef = _storage
        .ref()
        .child(FIREBASE_STORAGE_WORKOUT_IMAGES)
        .child('$workoutId')
        .child('$stepId')
        .child('${const Uuid().v4()}.png');
    storageRef.putFile(image);
  }

  Future<void> deleteImage(
      final String fileName, final int workoutId, final int stepId) async {
    var storageRef = _storage
        .ref()
        .child(FIREBASE_STORAGE_WORKOUT_IMAGES)
        .child('$workoutId')
        .child('$stepId')
        .child('${fileName}.png');
    await storageRef.delete();
  }
}
