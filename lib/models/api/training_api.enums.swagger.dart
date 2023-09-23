import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum ChangeWorkoutStepDtoWorkoutType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INTERVAL')
  interval('INTERVAL'),
  @JsonValue('REP')
  rep('REP');

  final String? value;

  const ChangeWorkoutStepDtoWorkoutType(this.value);
}

enum WorkoutStepDtoWorkoutType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INTERVAL')
  interval('INTERVAL'),
  @JsonValue('REP')
  rep('REP');

  final String? value;

  const WorkoutStepDtoWorkoutType(this.value);
}

enum ChangeWorkoutDtoCategory {
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

  const ChangeWorkoutDtoCategory(this.value);
}

enum ChangeWorkoutDtoDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const ChangeWorkoutDtoDifficulty(this.value);
}

enum WorkoutDtoCategory {
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

  const WorkoutDtoCategory(this.value);
}

enum WorkoutDtoDifficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('EASY')
  easy('EASY'),
  @JsonValue('INTERMEDIATE')
  intermediate('INTERMEDIATE'),
  @JsonValue('HARD')
  hard('HARD');

  final String? value;

  const WorkoutDtoDifficulty(this.value);
}
