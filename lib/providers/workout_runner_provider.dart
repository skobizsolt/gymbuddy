import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/service/workout_runner/runner_service.dart';

import '../models/step_record.dart';

var workoutRunnerStateProvider = StateNotifierProvider((ref) {
  ref.watch(authStateChangeProvider);
  return WorkoutRunnerService();
});

var recordsBySessionProvider =
    FutureProvider.family<List<StepRecord>, String>((ref, sessionId) {
  ref.watch(workoutRunnerStateProvider);
  return WorkoutRunnerService().getRecordsBySessionId(sessionId);
});

var activityByUserProvider = FutureProvider<List<SessionActivity>>((ref) {
  ref.watch(workoutRunnerStateProvider);
  return WorkoutRunnerService().getRecentActivity();
});

var activityBySessionIdProvider =
    FutureProvider.family<SessionActivity?, String>((ref, sessionId) {
  ref.watch(workoutRunnerStateProvider);
  ref.watch(recordsBySessionProvider(sessionId));
  var activities = ref.watch(activityByUserProvider).value;
  return activities == null
      ? null
      : activities.firstWhere((element) => element.sessionId == sessionId,
          orElse: null);
});
