import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/stopwatch.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout/create_step_record.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/screen/workout_runner/summary_screen.dart';
import 'package:gymbuddy/widgets/utils/big_elevatedButton.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class WorkoutRunnerScreen extends ConsumerStatefulWidget {
  final List<WorkoutStep> steps;
  final int workoutId;
  final String sessionId;

  const WorkoutRunnerScreen({
    super.key,
    required this.steps,
    required this.workoutId,
    required this.sessionId,
  });

  @override
  ConsumerState<WorkoutRunnerScreen> createState() =>
      _WorkoutRunnerScreenState();
}

class _WorkoutRunnerScreenState extends ConsumerState<WorkoutRunnerScreen> {
  var _index = 0;
  final _stepWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  final _totalWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  late bool _isSaving;

  @override
  void initState() {
    super.initState();
    _isSaving = false;
  }

  @override
  void dispose() async {
    super.dispose();
    await _stepWatchTimer.dispose();
    await _totalWatchTimer.dispose();
  }

  // Reset step timer and show next step
  _showNextStep(WorkoutStep currentStep) {
    _stepWatchTimer.onResetTimer();
    _addNewRecord(currentStep);
    setState(() {
      _index++;
    });
  }

  _addNewRecord(WorkoutStep currentStep) async {
    final newRecord = CreateStepRecord(
      workoutId: widget.workoutId,
      stepId: currentStep.stepId,
      sessionId: widget.sessionId,
      duration: Duration(milliseconds: _stepWatchTimer.rawTime.value).inSeconds,
    );
    try {
      await ref
          .read(workoutRunnerStateProvider.notifier)
          .addNewRecord(newRecord);
    } on Exception {
      showErrorSnackBar(
          context, "We could not save step: ${currentStep.stepName}");
    }
  }

  Future<void> _finishTraining(WorkoutStep currentStep) async {
    // Stopping session counters
    _stepWatchTimer.onStopTimer();
    _totalWatchTimer.onStopTimer();

    // Add last record and set saving state
    await _addNewRecord(currentStep);
    setState(() {
      _isSaving = true;
    });

    // Finish session
    try {
      await ref
          .read(workoutRunnerStateProvider.notifier)
          .finishTraining(widget.sessionId)
          .then((value) => ref.invalidate(activityByUserProvider));
    } on Exception {
      showErrorSnackBar(context,
          "We could not save everything about this session. Sorry for your inconvinience!");
    }

    // Switch screen to summary screen
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutSimulationSummaryScreen(
            workoutId: widget.workoutId,
            sessionId: widget.sessionId,
            newResult: true,
          ),
        ));
  }

  void _stopTraining() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          "Are you sure you want to stop this training?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          BackButton(color: Theme.of(context).colorScheme.primary),
          ElevatedButton.icon(
            onPressed: () {
              _stepWatchTimer.onStopTimer();
              _totalWatchTimer.clearPresetTime();
              ref.invalidate(activityByUserProvider);
              showSuccessSnackBar(context, "Training stopped!");
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.stop),
            label: const Text("Stop"),
          ),
        ],
      ),
    );
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
          _buildButtons(_isLastStep, _currentStep),
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

  _buildButtons(bool isLastStep, WorkoutStep currentStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: !_isSaving
          ? Column(
              children: [
                isLastStep
                    ? BigElevatedIconButton(
                        onPressed: () => _finishTraining(currentStep),
                        text: "Finish training",
                        icon: const Text('🏁'),
                      )
                    : BigElevatedIconButton(
                        onPressed: () => _showNextStep(currentStep),
                        text: "Next step",
                        icon: const Icon(Icons.navigate_next),
                      ),
                BigElevatedIconButton(
                  onPressed: _stopTraining,
                  text: "Abandon training",
                  icon: const Icon(Icons.stop),
                ),
              ],
            )
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: WaitingSpinner(
                title: "Fetching your results, stand by! 😎",
              ),
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
