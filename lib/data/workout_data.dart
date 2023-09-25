import 'package:gymbuddy/models/workout.dart';

final workoutData = [
  Workout(
    workoutId: 1,
    userId: "1",
    title: "TEST Workout 1",
    description: "Quick description",
    category: WorkoutCategory.strength,
    registeredOn: DateTime.now(),
    lastModified: DateTime.parse('20230701'),
    difficulty: WorkoutDifficulty.easy,
  ),
  Workout(
    workoutId: 2,
    userId: "2",
    title: "TEST Workout 2",
    category: WorkoutCategory.flexibility,
    registeredOn: DateTime.parse('20230601'),
    lastModified: DateTime.parse('20230728'),
    difficulty: WorkoutDifficulty.intermediate,
  ),
  Workout(
    workoutId: 3,
    userId: "1",
    title: "TEST Workout 3",
    description:
        'This is a test description for Test Workout 3. Any changes may occur.',
    category: WorkoutCategory.endurance,
    registeredOn: DateTime.parse('20230630'),
    lastModified: DateTime.parse('20230501'),
    difficulty: WorkoutDifficulty.hard,
  ),
  Workout(
    workoutId: 4,
    userId: "2",
    title: "TEST Workout 4",
    category: WorkoutCategory.flexibility,
    registeredOn: DateTime.parse('20230630'),
    lastModified: DateTime.parse('20230501'),
    difficulty: WorkoutDifficulty.hard,
  ),
];
