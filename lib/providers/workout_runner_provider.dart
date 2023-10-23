import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/service/workout_runner/runner_service.dart';

import '../models/workout/step_record.dart';

var workoutRunnerStateProvider =
    StateNotifierProvider((ref) => WorkoutRunnerService());

var runnerRecordsBySessionProvider =
    FutureProvider.family<List<StepRecord>, String>((ref, sessionId) {
  ref.watch(workoutRunnerStateProvider);
  return WorkoutRunnerService().getRecordsBySessionId(sessionId);
});
