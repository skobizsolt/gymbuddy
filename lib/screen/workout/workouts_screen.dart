import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({
    super.key,
    required this.workoutsRef,
  });

  final AsyncValue<List<Workout>> workoutsRef;

  Widget _renderWorkouts({required List<Workout> workoutList}) {
    return ListView.builder(
      itemCount: workoutList.length,
      itemBuilder: (context, index) {
        return WorkoutCard(workoutId: workoutList[index].workoutId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: _renderContent(context),
          ),
        );
      },
    );
  }

  Widget _renderContent(BuildContext context) {
    // Fetching data
    if (workoutsRef.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error during fetching data
    if (workoutsRef.hasError) {
      return const NoContentText(
        title: "Failed to fetch data! 😞",
        details: "Workout service currently unavailable",
      );
    }
    return workoutsRef.value!.isEmpty
        ? Center(
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
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _renderWorkouts(workoutList: workoutsRef.value!),
              ),
            ],
          );
  }
}
