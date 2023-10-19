import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/stopwatch.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout_runner/summary_screen.dart';
import 'package:gymbuddy/widgets/utils/big_elevatedButton.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class WorkoutRunnerScreen extends StatefulWidget {
  final List<WorkoutStep> steps;
  final int workoutId;

  const WorkoutRunnerScreen(
      {super.key, required this.steps, required this.workoutId});

  @override
  State<WorkoutRunnerScreen> createState() => _WorkoutRunnerScreenState();
}

class _WorkoutRunnerScreenState extends State<WorkoutRunnerScreen> {
  var _index = 0;
  final _stepWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  final _totalWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stepWatchTimer.dispose();
    await _totalWatchTimer.dispose();
  }

  _showNextStep() {
    _stepWatchTimer.onResetTimer();
    setState(() {
      _index++;
    });
  }

  void _finishTraining() {
    _stepWatchTimer.onStopTimer();
    _totalWatchTimer.onStopTimer();
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WorkoutSimulationSummaryScreen(workoutId: widget.workoutId),
        ));
  }

  void _stopTraining() {
    _stepWatchTimer.onStopTimer();
    _totalWatchTimer.clearPresetTime();
    showSuccessSnackBar(context, "Training stopped!");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Start timers
    _stepWatchTimer.onStartTimer();
    _totalWatchTimer.onStartTimer();

    var _currentStep = widget.steps[_index];
    final _isLastStep = _index == widget.steps.length - 1;
    return DribbleLayout(
      addAppBar: false,
      headerContent: _buildHeader(),
      body: Column(
        children: [
          _buildCurrentStepDisplay(_currentStep),
          const SizedBox(
            height: 8,
          ),
          _buildTabBarView(_currentStep),
          _buildTotalTime(),
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
    return InformationTag(
      child: currentStep.details.isEmpty
          ? Center(
              child: Text(
                "No instructions given.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            )
          : Text(
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
                  onPressed: _finishTraining,
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

  _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_index + 1}. step",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            StopWatchWidget(
              stopWatchTimer: _stepWatchTimer,
              fontSize: 40,
            ),
          ],
        ),
      ],
    );
  }

  _buildTotalTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '⏱️',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(
          width: 8,
        ),
        StopWatchWidget(
          stopWatchTimer: _totalWatchTimer,
          fontSize: 20,
        ),
      ],
    );
  }
}
