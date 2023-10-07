import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum EditWorkoutRequestCategory {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ENDURANCE')
  endurance('ENDURANCE'),
  @JsonValue('STRENGTH')
  strength('STRENGTH'),
  @JsonValue('BALANCE')
  balance('BALANCE'),
  @JsonValue('FLEXIBILITY')
  flexibility('FLEXIBILITY');

  final String? value;

  const EditWorkoutRequestCategory(this.value);
}

enum EditWorkoutRequestDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const EditWorkoutRequestDifficulty(this.value);
}

enum WorkoutResponseCategory {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ENDURANCE')
  endurance('ENDURANCE'),
  @JsonValue('STRENGTH')
  strength('STRENGTH'),
  @JsonValue('BALANCE')
  balance('BALANCE'),
  @JsonValue('FLEXIBILITY')
  flexibility('FLEXIBILITY');

  final String? value;

  const WorkoutResponseCategory(this.value);
}

enum WorkoutResponseDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const WorkoutResponseDifficulty(this.value);
}

enum ChangeWorkoutStepRequestWorkoutType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INTERVAL')
  interval('INTERVAL'),
  @JsonValue('REP')
  rep('REP');

  final String? value;

  const ChangeWorkoutStepRequestWorkoutType(this.value);
}

enum WorkoutStepResponseWorkoutType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INTERVAL')
  interval('INTERVAL'),
  @JsonValue('REP')
  rep('REP');

  final String? value;

  const WorkoutStepResponseWorkoutType(this.value);
}

enum CreateWorkoutRequestCategory {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ENDURANCE')
  endurance('ENDURANCE'),
  @JsonValue('STRENGTH')
  strength('STRENGTH'),
  @JsonValue('BALANCE')
  balance('BALANCE'),
  @JsonValue('FLEXIBILITY')
  flexibility('FLEXIBILITY');

  final String? value;

  const CreateWorkoutRequestCategory(this.value);
}

enum CreateWorkoutRequestDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const CreateWorkoutRequestDifficulty(this.value);
}
