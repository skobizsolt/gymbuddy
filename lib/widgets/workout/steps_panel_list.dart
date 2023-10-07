import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_details_screen.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class StepsPanelList extends ConsumerWidget {
  const StepsPanelList({
    super.key,
    required this.workoutId,
    this.isLocalMode = true,
    this.isOwnResource = false,
    this.isAuthEnabled = false,
  });

  final int workoutId;
  final bool isLocalMode;
  final bool isAuthEnabled;
  final bool isOwnResource;

  Future<void> openDetails(BuildContext context, WorkoutStep step) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: step,
          workoutId: workoutId,
        ),
      ),
    );
  }

  editStep(BuildContext context, WidgetRef ref, WorkoutStep step) async {
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => WorkoutStepManager(
              type: CrudType.edit,
              workoutStep: step,
            ),
          ),
        )
        .then(
          (value) => ref.read(workoutStepStateProvider.notifier).editStep(
              context: context,
              workoutId: workoutId,
              stepNumber: step.stepNumber,
              editedStep: value,
              isLocalMode: isLocalMode),
        );
  }

  deleteStep(
      BuildContext context, WidgetRef ref, final WorkoutStep step) async {
    if (!isLocalMode) {
      await ref
          .read(workoutStepStateProvider.notifier)
          .deleteStep(context, workoutId, step.stepNumber)
          .whenComplete(() => showSucessSnackBar(context,
              'Workout step "${step.stepName}" has been deleted successfully!'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stepsRef = ref.watch(workoutStepProvider(workoutId));
    if (!stepsRef.hasValue) {
      return const SizedBox();
    }

    List<WorkoutStep> workoutSteps = stepsRef.value!;
    // Notify the user if no steps added yet
    if (workoutSteps.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InformationTag(
              child: Text(
                isLocalMode ? 'No steps added yet' : 'No steps to show!',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: workoutSteps.length,
        itemBuilder: (context, index) {
          return isLocalMode || (isAuthEnabled && isOwnResource)
              ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) =>
                      deleteStep(context, ref, workoutSteps[index]),
                  child: _renderStepCard(context, ref, workoutSteps[index]),
                )
              : _renderStepCard(context, ref, workoutSteps[index]);
        },
      ),
    );
  }

  Widget _renderStepCard(
      BuildContext context, WidgetRef ref, WorkoutStep step) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        onTap: () => openDetails(context, step),
        title: Text(step.stepName),
        subtitle: Text(
          '${FormatUtils.toCapitalized(step.workoutType.name)} based step\n' +
              '${FormatUtils.toTimeString(Duration(seconds: step.estimatedTime))}',
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        trailing: isLocalMode || (isAuthEnabled && isOwnResource)
            ? IconButton(
                onPressed: () => editStep(context, ref, step),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : null,
      ),
    );
  }
}
