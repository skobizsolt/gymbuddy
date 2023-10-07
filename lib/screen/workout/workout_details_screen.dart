import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_modals.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/workout/steps_panel_list.dart';
import 'package:ionicons/ionicons.dart';

class WorkoutDetailsScreen extends ConsumerWidget {
  WorkoutDetailsScreen({super.key, required this.workoutId});

  final int workoutId;

  bool isResourceOwnedByTheUser(Workout workout) {
    return workout.userId == FirebaseAuth.instance.currentUser!.uid;
  }

  String calculateEstimatedTime(List<WorkoutStep> steps) {
    final duration = Duration(
        seconds: steps
            .map((step) => step.estimatedTime)
            .toList()
            .fold(0, (previousValue, element) => previousValue + element));
    return FormatUtils.toTimeString(duration);
  }

  editWorkout(final BuildContext context, Workout workout) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutManager(
          type: CrudType.edit,
          workout: workout,
        ),
      ),
    );
  }

  deleteWorkout(BuildContext context, WidgetRef ref, Workout workout) {
    Navigator.of(context).pop();
    ref
        .read(workoutStateProvider.notifier)
        .deleteWorkout(context, workout.workoutId)
        .then((value) => ref.invalidate(workoutStateProvider))
        .whenComplete(() => Navigator.of(context).pop());
  }

  addStep(
      {required BuildContext context,
      required WidgetRef ref,
      required CrudType type,
      required Workout workout}) async {
    final ChangeWorkoutStepDto? newStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(type: type),
      ),
    );
    if (newStep == null) {
      return;
    }
    await ref
        .read(workoutStepStateProvider.notifier)
        .createStep(context, workout.workoutId, newStep);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    var workoutRef = ref.watch(workoutByIdProvider(workoutId));
    var stepsRef = ref.watch(workoutStepProvider(workoutId));
    if (!(workoutRef.hasValue && stepsRef.hasValue)) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    Workout workout = workoutRef.value!;
    final steps = stepsRef.value!;
    final isSelfRecorce = isResourceOwnedByTheUser(workout);
    final estimatedTime = calculateEstimatedTime(steps);

    // Renders app bar buttons
    Widget renderAppBarButtons(int totalSteps) {
      // Delete Button
      return isSelfRecorce
          ? IconButton(
              onPressed: () => _showDeletionModal(
                context: context,
                ref: ref,
                workout: workout,
                totalSteps: totalSteps,
              ),
              icon: Icon(
                Icons.delete,
                color: onPrimaryContainer,
              ),
            )
          : const SizedBox();
    }

    // Renders the Workouts name
    Widget renderTitle() {
      return Row(
        children: [
          Expanded(
            child: Text(
              workout.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: onPrimaryContainer,
                    fontSize: 32,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    // Renders the total workout time and steps
    Widget renderDetail({
      required final String title,
      required final IconData icon,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: onPrimaryContainer,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: onPrimaryContainer,
                fontSize: 18,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    // Renders the type and difficulty and other future tags
    Widget renderTags() {
      var tags = [
        InformationTag(
          child: Text(
            '${workoutCategoryIcon[workout.category]} ${FormatUtils.toCapitalized(workout.category.name)}',
            style: TextStyle(color: primaryColor, fontSize: 14),
          ),
        ),
        InformationTag(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              workoutDifficultyRating[workout.difficulty] as Widget,
              const SizedBox(
                width: 5,
              ),
              Text(
                FormatUtils.toCapitalized(workout.difficulty.name),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ];

      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: isSelfRecorce,
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: tags[index],
            );
          },
        ),
      );
    }

    // Renders the deatils if added
    Widget renderDescription() {
      if (workout.description == null || workout.description!.isEmpty) {
        return const SizedBox();
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InformationTag(
                  child: Text(
                    workout.description!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }

    return DribbleLayout(
      actions: [
        // Delete button
        renderAppBarButtons(steps.length),
      ],
      headerContent: Column(
        children: [
          // Title
          renderTitle(),

          // Time to complete
          renderDetail(
            title: estimatedTime,
            icon: Icons.access_time_rounded,
          ),

          // Steps
          renderDetail(
              title: '${steps.length} Steps', icon: Ionicons.footsteps),

          const SizedBox(
            height: 8,
          ),

          // Edit workout button
          isSelfRecorce
              ? ElevatedButton.icon(
                  onPressed: () => editWorkout(context, workout),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit workout'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: onPrimaryContainer, elevation: 0),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tags
            renderTags(),
            const SizedBox(
              height: 20,
            ),

            // Description
            renderDescription(),

            // Steps
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Steps',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                // Add new step
                isSelfRecorce
                    ? InkWell(
                        onTap: () => addStep(
                            context: context,
                            ref: ref,
                            type: CrudType.add,
                            workout: workout),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4.0),
                            color: Theme.of(context).primaryColorLight,
                            child: Row(
                              children: [
                                const Text('Add new'),
                                Icon(
                                  Ionicons.add,
                                  size: 24,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            // Renders all steps belongs with this workout
            StepsPanelList(
              workoutId: workout.workoutId,
              isAuthEnabled: true,
              isOwnResource: isSelfRecorce,
            ),
          ],
        ),
      ),
      footing: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Launch'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDeletionModal(
      {required BuildContext context,
      required Workout workout,
      required int totalSteps,
      required WidgetRef ref}) {
    showConfirmDelete(
      context,
      title: RichText(
        // Controls visual overflow
        overflow: TextOverflow.clip,

        // Whether the text should break at soft line breaks
        softWrap: true,

        // The number of font pixels for each logical pixel
        textScaleFactor: 1,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          children: <TextSpan>[
            const TextSpan(
                text: 'Attention!\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
            const TextSpan(text: 'Workout '),
            TextSpan(
                text: '"${workout.title}"',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )),
            const TextSpan(text: ' with '),
            TextSpan(
                text: '$totalSteps steps',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            const TextSpan(text: ' is about to be deleted.'),
          ],
        ),
      ),
      subtitle: const Text("Are you sure? This operation cannot be undone!"),
      onTap: () => deleteWorkout(context, ref, workout),
    );
  }
}
