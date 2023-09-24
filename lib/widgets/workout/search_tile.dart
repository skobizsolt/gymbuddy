import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';

class WorkoutSearchTile extends ConsumerWidget {
  const WorkoutSearchTile({
    super.key,
    required this.workoutCategory,
  });
  final WorkoutCategory workoutCategory;

  List<Workout> loadData(WidgetRef ref) {
    var data = ref.refresh(workoutProvider);
    if (!data.hasValue) {
      return [];
    }
    return data.value!
        .where((workout) => workout.category == workoutCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String title =
        '${workoutCategory.name[0].toUpperCase() + workoutCategory.name.substring(1)} ${workoutCategoryIcon[workoutCategory]}';

    void onTap() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WorkoutsScreen(
          title: 'Category - $title',
          workouts: loadData(ref),
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
