import 'package:flutter/material.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/components/inputs/custom_searchbar.dart';
import 'package:gymbuddy/widgets/workout/search_tile.dart';

class SearchWorkoutsScreen extends StatelessWidget {
  const SearchWorkoutsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomSearchBar(),
              ),

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
      ),
    );
  }
}
