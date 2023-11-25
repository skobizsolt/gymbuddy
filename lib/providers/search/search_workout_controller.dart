import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout.dart';

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
