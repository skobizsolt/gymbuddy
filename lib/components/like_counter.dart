import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/workout_interaction_provider.dart';
import 'package:gymbuddy/service/workout/workout_interaction_service.dart';
import 'package:gymbuddy/widgets/utils/like_button.dart';

class LikeCounter extends ConsumerStatefulWidget {
  final int workoutId;
  const LikeCounter({
    super.key,
    required this.workoutId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeCounterState();
}

class _LikeCounterState extends ConsumerState<LikeCounter> {
  late bool _isLiked;
  late int _likes;
  final _interactions = WorkoutInteractionService();

  @override
  initState() {
    super.initState();
    _isLiked = false;
  }

  _loadData(Map<String, dynamic>? data) {
    final likers = data == null ? [] : data["likes"];

    _likes = likers.length;
    _isLiked = likers.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final snapshots = ref.watch(likesForWorkoutProvider(widget.workoutId));
    if (!snapshots.hasValue || snapshots.isLoading) {
      return const SizedBox();
    }

    _loadData(snapshots.value!.data());

    return Row(
      children: [
        LikeButton(onTap: _toggleLike, isLiked: _isLiked),
        const SizedBox(
          width: 4,
        ),
        Text(
          "$_likes",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ],
    );
  }

  void _toggleLike() {
    if (!_isLiked) {
      _interactions.likeWorkout(widget.workoutId);
    } else {
      _interactions.unlikeWorkout(widget.workoutId);
    }

    setState(() {
      _isLiked = !_isLiked;
    });
  }
}
