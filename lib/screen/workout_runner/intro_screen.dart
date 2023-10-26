import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/models/api/training_api.models.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/create_session.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
import 'package:gymbuddy/screen/workout_runner/runner_screen.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/big_elevatedButton.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class WorkoutRunnerIntroScreen extends ConsumerStatefulWidget {
  const WorkoutRunnerIntroScreen({super.key, required this.workoutId});

  final int workoutId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutReunnerIntroScreenState();
}

class _WorkoutReunnerIntroScreenState
    extends ConsumerState<WorkoutRunnerIntroScreen> {
  var _isStarted = false;

  _openSimulation(BuildContext context) async {
    setState(() {
      _isStarted = true;
    });
    final stepsRef = ref.watch(workoutStepProvider(widget.workoutId));
    late String sessionId;
    try {
      sessionId =
          await ref.read(workoutRunnerStateProvider.notifier).getSessionId(
                CreateWorkoutSessionRequest(
                  workoutId: widget.workoutId,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                ),
              );
    } on Exception {
      Navigator.pop(context);
      showErrorSnackBar(context,
          "Sorry, you can't start a new session. Please try again later.");
      return;
    }
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutRunnerScreen(
          workoutId: widget.workoutId,
          steps: stepsRef.value!,
          sessionId: sessionId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutRef = ref.read(workoutByIdProvider(widget.workoutId));
    final generalDetailsRef =
        ref.watch(workoutGeneralDetailsProvider(widget.workoutId));

    if (workoutRef.isLoading || generalDetailsRef.isLoading) {
      return const Scaffold(
        body: Center(
            child: WaitingSpinner(
          title: "Fetching data...",
        )),
      );
    }
    if (!(workoutRef.hasValue || generalDetailsRef.hasValue)) {
      Navigator.pop(context);
      showErrorSnackBar(context, "You can't launch this workout this time! 🙁");
    }

    final data = workoutRef.value!;
    final detailsData = generalDetailsRef.value!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildHeader(context, data, detailsData),
            SizedBox(
              height: GlobalValues.getScreenSize(context).height * 0.1,
            ),
            Expanded(
              child: _buildBody(context, data, detailsData),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isStarted
                  ? const WaitingSpinner(
                      title: "Starting new workout...",
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BigElevatedIconButton(
                          text: "Let's work out!",
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              '😍',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          onPressed: () => _openSimulation(context),
                        ),
                        BigElevatedIconButton(
                            icon: const Icon(Icons.arrow_back),
                            text: "Go back",
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader(
    BuildContext context,
    Workout data,
    WorkoutDetailsResponse detailsData,
  ) {
    return Row(
      children: [
        Container(
          width: GlobalValues.getScreenSize(context).width * 0.8,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InformationTag(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      child: SizedBox(
                        child: Text(
                          "${detailsData.totalSteps} steps, ${FormatUtils.toCapitalized(data.difficulty.name)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildBody(
    BuildContext context,
    Workout data,
    WorkoutDetailsResponse detailsData,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: GlobalValues.getScreenSize(context).width * 0.8,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '⏱ Est. time: ${FormatUtils.toTimeString(Duration(minutes: detailsData.estimatedTimeInMinutes!)).split(',')[0]}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InformationTag(
                      color: const Color.fromARGB(255, 250, 237, 116),
                      child: SizedBox(
                          width: double.infinity,
                          child: _buildHintText(context))),
                  const SizedBox(
                    height: 8,
                  ),
                  (data.description == null || data.description!.isEmpty)
                      ? const SizedBox()
                      : Expanded(
                          child: InformationTag(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                child: Text(
                                  data.description!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildHintText(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '💡',
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            "You are about to start a new training! Before you do, please read out our help page by tapping this dialog to have the best possible experience. Good luck, GymBuddy! 💪",
            softWrap: true,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
