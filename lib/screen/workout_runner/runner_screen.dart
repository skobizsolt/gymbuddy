import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/widgets/utils/big_elevatedButton.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';

class WorkoutRunnerScreen extends StatefulWidget {
  final List<WorkoutStep> steps;

  const WorkoutRunnerScreen({super.key, required this.steps});

  @override
  State<WorkoutRunnerScreen> createState() => _WorkoutRunnerScreenState();
}

class _WorkoutRunnerScreenState extends State<WorkoutRunnerScreen> {
  var _index = 0;

  _showNextStep() {
    setState(() {
      _index++;
    });
  }

  void _stopTraining() {
    showSuccessSnackBar(context, "Training stopped!");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var _currentStep = widget.steps[_index];
    final _isLastStep = _index == widget.steps.length - 1;
    return DribbleLayout(
      headerContent: Text(
        "00:00",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
      body: Column(
        children: [
          _buildCurrentStepDisplay(_currentStep),
          const SizedBox(
            height: 8,
          ),
          _buildTabBarView(_currentStep),
          _buildButtons(_isLastStep),
        ],
      ),
    );
  }

  _buildCurrentStepDisplay(WorkoutStep currentStep) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "The current step is...\n",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: currentStep.stepName,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTabBarView(WorkoutStep currentStep) {
    return Expanded(
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.info_outline),
                  text: "Step information",
                ),
                Tab(
                  icon: Icon(
                    Icons.play_circle,
                  ),
                  text: "Media",
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildStepInformation(currentStep),
                    const SizedBox(),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildStepInformation(WorkoutStep currentStep) {
    return currentStep.details.isEmpty
        ? const SizedBox()
        : InformationTag(
            child: Text(
              currentStep.details,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    letterSpacing: 1.5,
                  ),
              textAlign: TextAlign.justify,
            ),
          );
  }

  _buildButtons(bool isLastStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          isLastStep
              ? BigElevatedIconButton(
                  onPressed: () {},
                  text: "Finish training",
                  icon: const Text('🏁'),
                )
              : BigElevatedIconButton(
                  onPressed: _showNextStep,
                  text: "Next step",
                  icon: const Icon(Icons.navigate_next),
                ),
          BigElevatedIconButton(
            onPressed: _stopTraining,
            text: "Stop",
            icon: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}
