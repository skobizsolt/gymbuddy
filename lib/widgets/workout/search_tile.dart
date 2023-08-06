import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';

class WorkoutSearchTile extends StatelessWidget {
  const WorkoutSearchTile({
    super.key,
    required this.workoutCategory,
  });
  final WorkoutCategory workoutCategory;

  @override
  Widget build(BuildContext context) {
    final String title =
        '${workoutCategory.name[0].toUpperCase() + workoutCategory.name.substring(1)} ${workoutCategoryIcon[workoutCategory]}';

    void onTap() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WorkoutsScreen(
          title: 'Category - $title',
          selectedCategory: workoutCategory,
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(),
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
