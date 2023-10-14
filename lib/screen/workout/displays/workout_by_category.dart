import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';

class WorkoutByCategoryScreen extends ConsumerWidget {
  const WorkoutByCategoryScreen({super.key, required this.category});

  final WorkoutCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(workoutsByCategoryProvider(category));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category - ${FormatUtils.toCapitalized(category.name)}",
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async => ref.invalidate(workoutsProvider),
          child: WorkoutsScreen(workoutsRef: data)),
    );
  }
}
