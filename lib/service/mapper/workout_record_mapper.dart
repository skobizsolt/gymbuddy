import 'package:gymbuddy/models/api/workout_runner_api.models.swagger.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/models/step_record.dart';
import 'package:gymbuddy/models/workout.dart';

class WorkoutRecordMapper {
  static List<StepRecord> toStepRecordList(List<StepRecordResponse> response) {
    return response.map(toStepRecord).toList();
  }

  static StepRecord toStepRecord(StepRecordResponse response) {
    return StepRecord(
      stepId: response.stepId,
      completedAt: response.completedAt,
      duration: Duration(
        seconds: response.duration == null ? 0 : response.duration!.toInt(),
      ),
    );
  }

  static List<SessionActivity> toSessionActivityList(
      List<SessionActivityResponse> response) {
    return response.map(toSessionActivity).toList();
  }

  static SessionActivity toSessionActivity(SessionActivityResponse entry) {
    return SessionActivity(
      sessionId: entry.sessionId!,
      workoutId: entry.workoutId!,
      workoutName: entry.workoutName!,
      difficulty:
          WorkoutDifficulty.values.byName(entry.difficulty!.toLowerCase()),
      category: WorkoutCategory.values.byName(entry.category!.toLowerCase()),
      startedAt: entry.startedAt!,
      completedAt: entry.completedAt,
      completionStatus:
          CompletionStatus.values.byName(entry.completionStatus!.toLowerCase()),
      timeToComplete: Duration(seconds: entry.timeToComplete!.toInt()),
      completedInSeconds: Duration(seconds: entry.completedInSeconds!.toInt()),
    );
  }
}
