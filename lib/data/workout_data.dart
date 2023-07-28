import 'package:gymbuddy/models/workout.dart';

final workouts = [
  Workout(
      workoutId: 1,
      userId: 1,
      title: "TEST Workout 1",
      registeredOn: DateTime.now(),
      lastModified: DateTime.parse('20230701'),
      difficulty: WorkoutDifficulty.EASY,
      steps: 15,
      estimatedTimeInMinutes: 90),
  Workout(
      workoutId: 2,
      userId: 2,
      title: "TEST Workout 2",
      registeredOn: DateTime.parse('20230601'),
      lastModified: DateTime.parse('20230728'),
      difficulty: WorkoutDifficulty.INTERMEDIATE,
      steps: 10,
      estimatedTimeInMinutes: 30),
  Workout(
      workoutId: 3,
      userId: 1,
      title: "TEST Workout 3",
      registeredOn: DateTime.parse('20230630'),
      lastModified: DateTime.parse('20230501'),
      difficulty: WorkoutDifficulty.HARD,
      steps: 6,
      estimatedTimeInMinutes: 105),
];
