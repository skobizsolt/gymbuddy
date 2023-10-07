import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';

class WorkoutByCategoryScreen extends ConsumerWidget {
  const WorkoutByCategoryScreen({super.key, required this.category});

  final WorkoutCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(workoutByCategoryProvider(category));
    return WorkoutsScreen(
        title: "Category - ${category.name}", workoutsRef: data);
  }
}
