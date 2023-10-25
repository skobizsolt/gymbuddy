import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/models/step_record.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/big_elevatedButton.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class WorkoutSimulationSummaryScreen extends ConsumerWidget {
  final int workoutId;
  final String sessionId;
  final bool newResult;

  const WorkoutSimulationSummaryScreen({
    super.key,
    required this.workoutId,
    required this.sessionId,
    this.newResult = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutRef = ref.read(workoutByIdProvider(workoutId));
    final stepsRef = ref.read(workoutStepProvider(workoutId));
    final resultsRef = ref.watch(recordsBySessionProvider(sessionId));

    if (workoutRef.isLoading || stepsRef.isLoading) {
      return const Scaffold(
        body: Center(
          child: WaitingSpinner(title: "Loading your achievements... ⭐"),
        ),
      );
    }

    final workoutData = workoutRef.value!;
    final stepsData = stepsRef.value!;
    final List<StepRecord> summaryData =
        resultsRef.hasError || !resultsRef.hasValue ? [] : resultsRef.value!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Workout summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: _buildTimeline(stepsData, summaryData),
            ),
            BigElevatedIconButton(
                icon: const Icon(Icons.arrow_back),
                text: "Go back",
                onPressed: () {
                  Navigator.pop(context);
                  if (newResult) {
                    showSuccessSnackBar(context,
                        "Congratulations! You have completed: ${workoutData.title}");
                  }
                }),
          ],
        ),
      ),
    );
  }

  _buildInformationEntry(
    BuildContext context, {
    required final String title,
    required final String entry,
    final TextStyle? style,
    final double? padding,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 4),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: "$title: ",
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: entry,
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
        ]),
        style: style ?? Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  _buildTimeline(List<WorkoutStep> stepsData, List<StepRecord> summaryData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: stepsData.length,
      itemBuilder: (context, index) {
        final StepRecord? stepResult = summaryData.firstWhereOrNull(
          (element) => element.stepId == stepsData[index].stepId,
        );
        final bool hasData = stepResult != null;

        return TimelineTile(
          isFirst: index == 0,
          isLast: index == stepsData.length - 1,
          indicatorStyle: IndicatorStyle(
            color: hasData ? Colors.green : Theme.of(context).primaryColorLight,
          ),
          beforeLineStyle: LineStyle(
            color: hasData ? Colors.green : Theme.of(context).primaryColorLight,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
            child: GestureDetector(
              onTap: hasData ? () {} : () {},
              child: InformationTag(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInformationEntry(
                      context,
                      title: "Step",
                      entry: stepsData[index].stepName,
                      style: Theme.of(context).textTheme.titleLarge,
                      padding: 0,
                    ),
                    hasData
                        ? _buildInformationEntry(
                            context,
                            title: "Completed at",
                            entry:
                                "${FormatUtils.formatDateTime(stepResult.completedAt)}",
                          )
                        : const SizedBox(),
                    _buildInformationEntry(
                      context,
                      title: "Expected time to complete",
                      entry: "${FormatUtils.toTimeString(
                        new Duration(
                          seconds: stepsData[index].estimatedTime,
                        ),
                      )}",
                    ),
                    hasData
                        ? _buildInformationEntry(
                            context,
                            title: "You completed this step in",
                            entry:
                                "${FormatUtils.toTimeString(stepResult.duration!)}",
                          )
                        : const SizedBox(),
                    !hasData
                        ? _buildInformationEntry(
                            context,
                            title: "Status",
                            entry: "Not completed",
                          )
                        : const SizedBox(),
                    hasData
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Tap for details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
