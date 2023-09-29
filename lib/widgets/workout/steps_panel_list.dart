import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_details_screen.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/mapper/workout_internal_mapper.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_step_service.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class StepsPanelList extends StatefulWidget {
  const StepsPanelList({
    super.key,
    required this.workoutSteps,
    required this.workoutId,
    this.isLocalMode = true,
    this.isOwnResource = false,
    this.isAuthEnabled = false,
  });

  final List<WorkoutStep> workoutSteps;
  final int workoutId;
  final bool isLocalMode;
  final bool isAuthEnabled;
  final bool isOwnResource;

  @override
  State<StepsPanelList> createState() => _StepsPanelListState();
}

class _StepsPanelListState extends State<StepsPanelList> {
  final _workoutStepService = WorkoutStepService();
  final _internalMapper = WorkoutInternalDataMapper();

  List<WorkoutStep> get steps {
    widget.workoutSteps.sort(
        (step, nextStep) => step.stepNumber.compareTo(nextStep.stepNumber));
    return widget.workoutSteps;
  }

  Future<void> openDetails(BuildContext context, WorkoutStep step) async {
    final WorkoutStep? editedStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepDetailsScreen(
          step: step,
          workoutId: widget.workoutId,
        ),
      ),
    );

    if (editedStep == null || editedStep == step) {
      return;
    }

    setState(() {
      steps[steps.indexOf(step)] = editedStep;
    });
  }

  editStep(BuildContext context, final int index) async {
    ChangeWorkoutStepDto? editedStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(
          type: CrudType.edit,
          workoutStep: steps[index],
        ),
      ),
    );

    if (editedStep == null) {
      return;
    }

    if (!widget.isLocalMode &&
        widget.workoutId != GlobalValues.LOCAL_WORKOUT_ID) {
      _workoutStepService.editStep(
          context, widget.workoutId, steps[index].stepNumber, editedStep);
    }

    setState(() {
      steps[index] =
          _internalMapper.toWorkoutStep(editedStep, steps[index].stepNumber);
    });
  }

  deleteStep(BuildContext context, final WorkoutStep step) async {
    if (!widget.isLocalMode) {
      await WorkoutStepService()
          .deleteStep(context, widget.workoutId, step.stepNumber)
          .whenComplete(() => showSucessSnackBar(context,
              'Workout step "${step.stepName}" has been deleted successfully!'));
    }
    setState(() {
      steps.remove(step);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Notify the user if no steps added yet
    if (steps.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InformationTag(
              child: Text(
                widget.isLocalMode ? 'No steps added yet' : 'No steps to show!',
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
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return widget.isLocalMode ||
                  (widget.isOwnResource && widget.isOwnResource)
              ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => deleteStep(context, steps[index]),
                  child: _renderStepCard(index),
                )
              : _renderStepCard(index);
        },
      ),
    );
  }

  Widget _renderStepCard(int index) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        onTap: () => openDetails(context, steps[index]),
        title: Text(steps[index].stepName),
        subtitle: Text(
          '${FormatUtils.toCapitalized(steps[index].workoutType.name)} based step\n${FormatUtils.toTimeString(Duration(seconds: steps[index].estimatedTime))}',
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        trailing:
            widget.isLocalMode || (widget.isAuthEnabled && widget.isOwnResource)
                ? IconButton(
                    onPressed: () => editStep(context, index),
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
