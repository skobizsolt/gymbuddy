import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout_likes.dart';
import 'package:gymbuddy/providers/workout_interaction_provider.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

enum WorkoutInteraction { saved, popular }

class WorkoutByInteractionScreen extends ConsumerWidget {
  final WorkoutInteraction interaction;

  const WorkoutByInteractionScreen({
    required this.interaction,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<WorkoutInteraction, String> titles = {
      WorkoutInteraction.saved: "Saved Workouts",
      WorkoutInteraction.popular: "Most liked workouts"
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[interaction]!,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(filterWorkoutsByIdsProvider),
        child: _renderContent(ref),
      ),
    );
  }

  _renderContent(WidgetRef ref) {
    var likesRef = ref.watch(likesByUserProvider);
    if (likesRef.isLoading) {
      return const WaitingSpinner(title: "Loading data...");
    }

    var likedWorkouts = likesRef.value!;
    var likedWorkoutIds = _getIds(likedWorkouts);

    var data = ref.watch(filterWorkoutsByIdsProvider(likedWorkoutIds));

    return WorkoutsScreen(workoutsRef: data);
  }

  List<int> _getIds(List<WorkoutLikes> likedWorkouts) {
    List<int> workoutIds = [];
    if (interaction == WorkoutInteraction.saved) {
      likedWorkouts
          .where((element) =>
              element.likes.contains(FirebaseAuth.instance.currentUser!.uid))
          .toList()
          .forEach((element) {
        workoutIds.add(element.workoutId);
      });
    }
    if (interaction == WorkoutInteraction.popular) {
      likedWorkouts.sort(
        (b, a) => a.likes.length.compareTo(b.likes.length),
      );
      likedWorkouts
          .where((element) => element.likes.isNotEmpty)
          .toList()
          .forEach((element) {
        workoutIds.add(element.workoutId);
      });
    }
    return workoutIds;
  }
}
