import 'package:flutter/foundation.dart';

class WorkoutLikes {
  int workoutId;
  List<String> likes;
  WorkoutLikes({
    required this.workoutId,
    required this.likes,
  });

  WorkoutLikes copyWith({
    int? workoutId,
    List<String>? likes,
  }) {
    return WorkoutLikes(
      workoutId: workoutId ?? this.workoutId,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workoutId': workoutId,
      'likes': likes,
    };
  }

  @override
  String toString() => 'WorkoutLikes(workoutId: $workoutId, likes: $likes)';

  @override
  bool operator ==(covariant WorkoutLikes other) {
    if (identical(this, other)) return true;

    return other.workoutId == workoutId && listEquals(other.likes, likes);
  }

  @override
  int get hashCode => workoutId.hashCode ^ likes.hashCode;
}
