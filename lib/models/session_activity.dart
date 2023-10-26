import 'package:gymbuddy/models/workout.dart';

class SessionActivity {
  String sessionId;
  int workoutId;
  String workoutName;
  WorkoutDifficulty difficulty;
  WorkoutCategory category;
  DateTime startedAt;
  DateTime? completedAt;
  CompletionStatus completionStatus;
  Duration timeToComplete;
  Duration completedInSeconds;
  SessionActivity({
    required this.sessionId,
    required this.workoutId,
    required this.workoutName,
    required this.difficulty,
    required this.category,
    required this.startedAt,
    this.completedAt,
    required this.completionStatus,
    required this.timeToComplete,
    required this.completedInSeconds,
  });

  SessionActivity copyWith({
    String? sessionId,
    int? workoutId,
    String? workoutName,
    WorkoutDifficulty? difficulty,
    WorkoutCategory? category,
    DateTime? startedAt,
    DateTime? completedAt,
    CompletionStatus? completionStatus,
    Duration? timeToComplete,
    Duration? completedInSeconds,
  }) {
    return SessionActivity(
      sessionId: sessionId ?? this.sessionId,
      workoutId: workoutId ?? this.workoutId,
      workoutName: workoutName ?? this.workoutName,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      completionStatus: completionStatus ?? this.completionStatus,
      timeToComplete: timeToComplete ?? this.timeToComplete,
      completedInSeconds: completedInSeconds ?? this.completedInSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionId': sessionId,
      'workoutId': workoutId,
      'workoutName': workoutName,
      'difficulty': difficulty.name,
      'category': category.name,
      'startedAt': startedAt.millisecondsSinceEpoch,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'completionStatus': completionStatus.name,
      'timeToComplete': timeToComplete.inSeconds,
      'completedInSeconds': completedInSeconds.inSeconds,
    };
  }

  @override
  String toString() {
    return 'SessionActivity(sessionId: $sessionId, workoutId: $workoutId, workoutName: $workoutName, difficulty: $difficulty, category: $category, startedAt: $startedAt, completedAt: $completedAt, completionStatus: $completionStatus, timeToComplete: $timeToComplete, completedInSeconds: $completedInSeconds)';
  }

  @override
  bool operator ==(covariant SessionActivity other) {
    if (identical(this, other)) return true;

    return other.sessionId == sessionId &&
        other.workoutId == workoutId &&
        other.workoutName == workoutName &&
        other.difficulty == difficulty &&
        other.category == category &&
        other.startedAt == startedAt &&
        other.completedAt == completedAt &&
        other.completionStatus == completionStatus &&
        other.timeToComplete == timeToComplete &&
        other.completedInSeconds == completedInSeconds;
  }

  @override
  int get hashCode {
    return sessionId.hashCode ^
        workoutId.hashCode ^
        workoutName.hashCode ^
        difficulty.hashCode ^
        category.hashCode ^
        startedAt.hashCode ^
        completedAt.hashCode ^
        completionStatus.hashCode ^
        timeToComplete.hashCode ^
        completedInSeconds.hashCode;
  }
}

enum CompletionStatus { not_completed, completed }
