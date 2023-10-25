import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/screen/workout_runner/summary_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';

class WorkoutActivityCard extends ConsumerWidget {
  const WorkoutActivityCard({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workoutRef = ref.watch(activityBySessionIdProvider(sessionId));
    if (!workoutRef.hasValue) {
      return const SizedBox();
    }

    SessionActivity session = workoutRef.value!;
    Future<void> _openSessionSummary() async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => WorkoutSimulationSummaryScreen(
                workoutId: session.workoutId,
                sessionId: sessionId,
              )),
        ),
      );
    }

    Widget _buildSessionDetails() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.workoutName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${workoutCategoryIcon[session.category]} ' +
                  '${FormatUtils.toCapitalized(session.category.name)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            workoutDifficultyRating[session.difficulty] as Widget,
          ],
        ),
      );
    }

    return Card(
      child: InkWell(
        onTap: _openSessionSummary,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSessionDetails(),
                  Column(children: [
                    Text(
                      session.completionStatus == CompletionStatus.completed
                          ? '✅'
                          : '❌',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    )
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
