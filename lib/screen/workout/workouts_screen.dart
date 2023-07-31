import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsSceen extends StatelessWidget {
  const WorkoutsSceen({super.key, required this.workouts});

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    Widget renderOptions() {
      return Expanded(
        child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            return WorkoutCard(
              workout: workouts[index],
            );
          },
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Find your newest exercise! 🏅',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 24,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            // Add Actions
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // add new option
                      renderOptions()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
