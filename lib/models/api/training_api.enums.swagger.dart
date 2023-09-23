import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

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

enum ChangeWorkoutRequestCategory {
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

  const ChangeWorkoutRequestCategory(this.value);
}

enum ChangeWorkoutRequestDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const ChangeWorkoutRequestDifficulty(this.value);
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
