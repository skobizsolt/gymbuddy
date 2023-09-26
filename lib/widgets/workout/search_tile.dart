import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';

class WorkoutSearchTile extends StatelessWidget {
  const WorkoutSearchTile({
    super.key,
    required this.workoutCategory,
  });
  final WorkoutCategory workoutCategory;

  Future<List<Workout>> loadData() async {
    var data = await WorkoutService().getWorkouts();
    if (data.isEmpty) {
      return [];
    }
    return data
        .where((workout) => workout.category == workoutCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        '${FormatUtils.toCapitalized(workoutCategory.name)} ${workoutCategoryIcon[workoutCategory]}';

    Future<void> onTap() async {
      final loadedWorkouts = await loadData();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WorkoutsScreen(
          title: 'Category - $title',
          workouts: loadedWorkouts,
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
