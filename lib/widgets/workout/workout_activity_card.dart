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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Workout name
                  Text(
                    session.workoutName,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),

                  Text(
                    '${workoutCategoryIcon[session.category]} ' +
                        '${FormatUtils.toCapitalized(session.category.name)}, ' +
                        '${FormatUtils.toCapitalized(session.difficulty.name)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  session.completedAt == null
                      ? Text(
                          "Not completed",
                          style: const TextStyle().copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),

          // Time spent in training
          _renderDetailEntry(
              title: "Time spent in training",
              detail:
                  "${FormatUtils.toTimeString(session.completedInSeconds)}"),
          // Time spent in training
          _renderDetailEntry(
              title: "Estimate was",
              detail: "${FormatUtils.toTimeString(session.timeToComplete)}"),

          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),

          // Starting time
          _renderDetailEntry(
            title: "Started at",
            detail: FormatUtils.formatDateTime(session.startedAt),
          ),

          // Completion time
          session.completedAt == null
              ? const SizedBox()
              : _renderDetailEntry(
                  title: "Completed",
                  detail: FormatUtils.formatDateTime(session.completedAt),
                  color: Colors.green,
                ),
        ],
      );
    }

    return Card(
      child: InkWell(
        onTap: _openSessionSummary,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: _buildSessionDetails(),
        ),
      ),
    );
  }

  _renderDetailEntry(
      {required final String title,
      required final String detail,
      final Color? color}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$title: ",
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          TextSpan(
              text: '$detail',
              style: const TextStyle().copyWith(
                color: color,
              )),
        ],
      ),
    );
  }
}
