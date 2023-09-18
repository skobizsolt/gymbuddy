import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_data.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/search_workouts_screen.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';

class HomeOption extends StatelessWidget {
  const HomeOption({
    super.key,
    required this.id,
    required this.optionName,
    required this.icon,
  });

  final int id;
  final String optionName;
  final IconData icon;

  void searchWorkouts(BuildContext context, List<Workout> workouts) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchWorkoutsSceen(
          workouts: workouts,
        ),
      ),
    );
  }

  void addNewTraining(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutManager(
          type: CrudType.add,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (id == 0) {
            searchWorkouts(context, workoutData);
          }
          if (id == 2) {
            addNewTraining(context);
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  optionName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
