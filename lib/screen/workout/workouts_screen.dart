import 'package:flutter/material.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({
    super.key,
    required this.title,
    required this.workouts,
  });

  final String title;
  final List<Workout> workouts;

  Widget _renderWorkouts({required List<Workout> workoutList}) {
    return ListView.builder(
      itemCount: workoutList.length,
      itemBuilder: (context, index) {
        return WorkoutCard(workout: workoutList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget renderContent() {
      if (workouts.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const NoContentText(
                title: 'Nothing here yet 😞',
                details: 'Let\'s add a new workout!',
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkoutManager(type: CrudType.add),
                  ),
                ),
                style: const ButtonStyle().copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorDark)),
                icon: const Icon(Icons.add),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Create a new training now!',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              )
            ],
          ),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _renderWorkouts(workoutList: workouts),
            ),
          ],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: renderContent(),
      ),
    );
  }
}
