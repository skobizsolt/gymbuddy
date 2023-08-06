import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/widgets/utils/custom_text_input.dart';
import 'package:gymbuddy/widgets/workout/search_tile.dart';

class SearchWorkoutsSceen extends StatelessWidget {
  const SearchWorkoutsSceen({super.key, required this.workouts});

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            // Title
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Find your newest exercise! 🏅',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 24,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // Search Bar
            const CustomTextInput(labelText: 'Search', icon: Icons.search),

            const SizedBox(
              height: 60,
            ),

            // Categories grid view
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: workoutCategoryIcon.length,
              itemBuilder: (_, index) {
                final category = WorkoutCategory.values[index];
                return WorkoutSearchTile(workoutCategory: category);
              },
            ),
          ],
        ),
      ),
    );
  }
}
