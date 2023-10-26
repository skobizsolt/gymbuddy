import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';
import 'package:gymbuddy/widgets/workout/workout_activity_card.dart';

class RecentWorkoutHistoryScreen extends ConsumerWidget {
  const RecentWorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sessionsRef = ref.watch(activityByUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My past achievements ⭐"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async => await ref.refresh(activityByUserProvider),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: _renderContent(context, sessionsRef),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderContent(
    BuildContext context,
    AsyncValue<List<SessionActivity>> sessionsRef,
  ) {
    // Fetching data
    if (sessionsRef.isLoading) {
      return const Center(
        child: WaitingSpinner(
          title: "Fetching data...",
        ),
      );
    }

    // Error during fetching data
    if (sessionsRef.hasError) {
      return const NoContentText(
        title: "Failed to fetch data! 😞",
        details: "Workout service currently unavailable!",
      );
    }
    return sessionsRef.value!.isEmpty
        ? const Center(
            child: NoContentText(
              title: 'Nothing here yet 😞',
              details: 'You\'re probably new here 👋\n' +
                  'Start a new workout of your liking and your results will be shown!',
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _renderActivities(sessionActivities: sessionsRef.value!),
            ],
          );
  }

  Widget _renderActivities({required List<SessionActivity> sessionActivities}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessionActivities.length,
      itemBuilder: (context, index) {
        return WorkoutActivityCard(
            sessionId: sessionActivities[index].sessionId);
      },
    );
  }
}
