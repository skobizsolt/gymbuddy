import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/chats/chat_person.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/search/search_chatter_controller.dart';
import 'package:gymbuddy/providers/search/search_workout_controller.dart';

final searchTermState = StateProvider((ref) => '');

final searchWorkoutControllerProvider =
    StateNotifierProvider<SearchWorkoutController, List<Workout>>((ref) {
  ref.watch(searchTermState);
  return SearchWorkoutController();
});

final searchChatterControllerProvider =
    StateNotifierProvider<SearchUserController, List<ChatPerson>>((ref) {
  return SearchUserController();
});
