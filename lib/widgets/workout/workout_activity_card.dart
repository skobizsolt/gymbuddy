import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/models/session_activity.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/screen/workout_runner/summary_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';

class WorkoutActivityCard extends ConsumerWidget {
  const WorkoutActivityCard({
    super.key,
    required this.sessionId,
    this.minimal = false,
  });
  final String sessionId;
  final bool minimal;

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
          _renderTitle(context, session),
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
          _renderCompletedAt(session.completedAt)
        ],
      );
    }

    _buildMinimalSessionDetails() {
      return Column(
        children: [
          _renderTitle(context, session),
          // Completion time
          _renderCompletedAt(session.completedAt),
        ],
      );
    }

    return Card(
      child: InkWell(
        onTap: _openSessionSummary,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child:
              minimal ? _buildMinimalSessionDetails() : _buildSessionDetails(),
        ),
      ),
    );
  }

  _renderTitle(BuildContext context, SessionActivity session) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Workout name
          Text(
            session.workoutName,
            textAlign: TextAlign.center,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
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

  _renderCompletedAt(DateTime? completedAt) {
    return completedAt == null
        ? const SizedBox()
        : _renderDetailEntry(
            title: "Completed",
            detail: FormatUtils.formatDateTime(completedAt),
            color: Colors.green,
          );
  }
}
