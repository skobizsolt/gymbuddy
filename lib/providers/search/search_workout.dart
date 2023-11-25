import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';

final searchWorkoutControllerProvider =
    StateNotifierProvider<SearchWorkoutController, List<Workout>>((ref) {
  ref.watch(searchWorkoutState);
  return SearchWorkoutController();
});

final searchWorkoutState = StateProvider((ref) => '');

class SearchWorkoutController extends StateNotifier<List<Workout>> {
  SearchWorkoutController() : super([]);
  void onSearch(String query, List<Workout> chatters) {
    state = [];
    if (query.isNotEmpty) {
      final result = chatters
          .where(
            (element) =>
                element.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      state.addAll(result);
    }
  }
}
