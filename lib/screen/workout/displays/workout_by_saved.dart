import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/workout_likes.dart';
import 'package:gymbuddy/providers/workout_interaction_provider.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workouts_screen.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class WorkoutBySavedScreen extends ConsumerWidget {
  const WorkoutBySavedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Workouts",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(userFavouriteProvider),
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

    var data = ref.watch(userFavouriteProvider(likedWorkoutIds));

    return WorkoutsScreen(workoutsRef: data);
  }

  List<int> _getIds(List<WorkoutLikes> likedWorkouts) {
    List<int> workoutIdslikedByUser = [];
    likedWorkouts
        .where((element) =>
            element.likes.contains(FirebaseAuth.instance.currentUser!.uid))
        .toList()
        .forEach((element) {
      workoutIdslikedByUser.add(element.workoutId);
    });
    return workoutIdslikedByUser;
  }
}
