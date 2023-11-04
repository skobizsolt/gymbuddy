import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout/workout_ids.dart';
import 'package:gymbuddy/service/workout/workout_step_media_service.dart';

var workoutStepMediaProvider =
    FutureProvider.family<List<String>, WorkoutIds>((ref, ids) {
  return WorkoutStepMediaService().getImageUrls(ids);
});
