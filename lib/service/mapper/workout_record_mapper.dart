import 'package:gymbuddy/models/api/workout_runner_api.models.swagger.dart';
import 'package:gymbuddy/models/workout/step_record.dart';

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
}
