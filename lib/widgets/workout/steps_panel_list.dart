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

class StepsPanelList extends ConsumerStatefulWidget {
  const StepsPanelList({
    super.key,
    required this.workoutId,
    this.isOwnResource = false,
    this.isAuthEnabled = false,
  });

  final int workoutId;
  final bool isAuthEnabled;
  final bool isOwnResource;

  @override
  ConsumerState<StepsPanelList> createState() => _StepsPanelListState();
}

class _StepsPanelListState extends ConsumerState<StepsPanelList> {
  Future<void> openDetails(
      BuildContext context, WorkoutStep step, int placeInList) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: step,
          workoutId: widget.workoutId,
          placeInList: placeInList,
        ),
      ),
    );
  }

  editStep(
    BuildContext context,
    WidgetRef ref,
    WorkoutStep step,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(
          workoutId: widget.workoutId,
          type: CrudType.edit,
          workoutStep: step,
          stepNumber: step.stepNumber,
        ),
      ),
    );
  }

  deleteStep(BuildContext context, WidgetRef ref, final List<WorkoutStep> steps,
      int index) async {
    final deletedStep = steps[index];
    try {
      await ref
          .read(workoutStepStateProvider.notifier)
          .deleteStep(context, widget.workoutId, deletedStep.stepNumber)
          .then((value) => showSuccessSnackBar(context,
              'Workout step "${deletedStep.stepName}" has been deleted successfully!'));
    } on Exception {
      showErrorSnackBar(context,
          "Error happened during step deletion, please try again later!");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var stepsRef = ref.watch(workoutStepProvider(widget.workoutId));
    if (!stepsRef.hasValue) {
      return const SizedBox();
    }

    List<WorkoutStep> workoutSteps = stepsRef.value!;
    workoutSteps.sort(
      (a, b) => a.stepNumber.compareTo(b.stepNumber),
    );
    // Notify the user if no steps added yet
    if (workoutSteps.isEmpty) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InformationTag(
              child: Text(
                'No steps added yet. Add a new one to run this training!',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async =>
          ref.invalidate(workoutStepProvider(widget.workoutId)),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: workoutSteps.length,
          itemBuilder: (context, index) {
            return widget.isAuthEnabled && widget.isOwnResource
                ? Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) =>
                        deleteStep(context, ref, workoutSteps, index),
                    child: _renderStepCard(
                        context, ref, workoutSteps[index], index),
                  )
                : _renderStepCard(context, ref, workoutSteps[index], index);
          },
        ),
      ),
    );
  }

  Widget _renderStepCard(
    BuildContext context,
    WidgetRef ref,
    WorkoutStep step,
    int index,
  ) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        onTap: () => openDetails(context, step, index + 1),
        title: Text(step.stepName),
        subtitle: Text(
          '${FormatUtils.toCapitalized(step.workoutType.name)} based step\n' +
              '${FormatUtils.toTimeString(Duration(seconds: step.estimatedTime))}',
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        trailing: widget.isAuthEnabled && widget.isOwnResource
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
