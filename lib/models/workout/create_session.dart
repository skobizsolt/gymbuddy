// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateWorkoutSessionRequest {
  int? workoutId;
  String? userId;
  CreateWorkoutSessionRequest({
    this.workoutId,
    this.userId,
  });

  CreateWorkoutSessionRequest copyWith({
    int? workoutId,
    String? userId,
  }) {
    return CreateWorkoutSessionRequest(
      workoutId: workoutId ?? this.workoutId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workoutId': workoutId,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'CreateWorkoutSessionRequest(workoutId: $workoutId, userId: $userId)';

  @override
  bool operator ==(covariant CreateWorkoutSessionRequest other) {
    if (identical(this, other)) return true;

    return other.workoutId == workoutId && other.userId == userId;
  }

  @override
  int get hashCode => workoutId.hashCode ^ userId.hashCode;
}
