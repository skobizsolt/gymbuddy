import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';

class WorkoutsByUser extends ConsumerWidget {
  const WorkoutsByUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(workoutsByUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My workouts",
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () => _refresh(ref, data),
          child: WorkoutsScreen(workoutsRef: data)),
    );
  }

  _refresh(WidgetRef ref, AsyncValue<List<Workout>> data) async {
    data = ref.refresh(workoutsByUserProvider);
  }
}
