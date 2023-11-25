import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/inputs/custom_searchbar.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/search/search_provider.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';
import 'package:gymbuddy/widgets/workout/workout_card.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({
    super.key,
    required this.workoutsRef,
  });

  final AsyncValue<List<Workout>?> workoutsRef;

  Widget _renderWorkouts({
    required List<Workout> allItems,
    required List<Workout> searchedItems,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          searchedItems.isNotEmpty ? searchedItems.length : allItems.length,
      itemBuilder: (context, index) {
        return WorkoutCard(
            workoutId: searchedItems.isNotEmpty
                ? searchedItems[index].workoutId
                : allItems[index].workoutId);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchWorkoutControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        KeyboardService.closeKeyboard;
        ref.invalidate(searchTermState);
        return true;
      },
      child: GestureDetector(
        onTap: KeyboardService.closeKeyboard,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: workoutsRef.when(
                  data: (data) => data!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const NoContentText(
                                title: 'Nothing here yet 😞',
                                details: "Let's add a new workout!",
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton.icon(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WorkoutManager(type: CrudType.add),
                                  ),
                                ),
                                style: const ButtonStyle().copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColorDark)),
                                icon: const Icon(Icons.add),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text('Create a new training now!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                              )
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Search Bar
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: _buildSearchBar(context, ref, data),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            _renderWorkouts(
                                allItems: data,
                                searchedItems: searchController),
                          ],
                        ),
                  error: (error, stackTrace) => const NoContentText(
                    title: "Failed to fetch data! 😞",
                    details: "Workout service currently unavailable!",
                  ),
                  loading: () => const Center(
                    child: WaitingSpinner(
                      title: "Fetching data...",
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildSearchBar(BuildContext context, WidgetRef ref, List<Workout> data) {
    return CustomSearchBar(
      onChanged: (value) {
        var searchTerm =
            ref.watch(searchTermState.notifier).update((state) => value);
        ref
            .read(searchWorkoutControllerProvider.notifier)
            .onSearch(searchTerm, data);
      },
      color: Theme.of(context).primaryColorLight,
    );
  }
}
