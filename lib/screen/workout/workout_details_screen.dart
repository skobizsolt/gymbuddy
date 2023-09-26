import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/dribble_layout.dart';
import 'package:gymbuddy/models/api/training_api.swagger.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/screen/workout/workout_manager.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';
import 'package:gymbuddy/widgets/utils/information_tag.dart';
import 'package:gymbuddy/widgets/workout/steps_panel_list.dart';
import 'package:ionicons/ionicons.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  WorkoutDetailsScreen({super.key, required this.workout, this.steps});

  final Workout workout;
  final List<WorkoutStep>? steps;

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  final _workoutService = WorkoutService();
  late Workout workoutData;
  late List<WorkoutStep> stepsData;
  late Stream<WorkoutDetailsResponse> generalStepsData;

  bool get isSelfResource {
    return widget.workout.userId == FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  initState() {
    super.initState();
    workoutData = widget.workout;
    stepsData = widget.steps ?? [];
    generalStepsData = loadDetails(context);
  }

  Stream<WorkoutDetailsResponse> loadDetails(BuildContext context) {
    return _workoutService.getGeneralStepDetails(
        widget.workout.workoutId, context);
  }

  editWorkout(final BuildContext context) async {
    final Workout? editedWorkout = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutManager(
          type: CrudType.edit,
          workout: workoutData,
        ),
      ),
    );
    if (editedWorkout == null) {
      return;
    }
    setState(() {
      workoutData = editedWorkout;
    });
  }

  deleteWorkout(BuildContext context) {
    Navigator.of(context).pop();
    _workoutService.deleteWorkout(context, workoutData.workoutId);
  }

  addStep(BuildContext context, CrudType type) async {
    final ChangeWorkoutStepDto? newStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(type: type),
      ),
    );
    if (newStep == null) {
      return;
    }
    await _workoutService
        .createStep(context, workoutData.workoutId, newStep)
        .then(
          (value) => setState(
            () {
              stepsData.add(value);
              generalStepsData = loadDetails(context);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    // Renders app bar buttons
    Widget renderAppBarButtons(int totalSteps) {
      // Delete Button
      return Visibility(
        visible: isSelfResource,
        child: IconButton(
          onPressed: () =>
              _showConfirmDeleteDialog(workoutData.title, totalSteps),
          icon: Icon(
            Icons.delete,
            color: onPrimaryContainer,
          ),
        ),
      );
    }

    // Renders the Workouts name
    Widget renderTitle() {
      return Row(
        children: [
          Expanded(
            child: Text(
              workoutData.title,
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
            '${workoutCategoryIcon[workoutData.category]} ${FormatUtils.toCapitalized(workoutData.category.name)}',
            style: TextStyle(color: primaryColor, fontSize: 14),
          ),
        ),
        InformationTag(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              workoutDifficultyRating[workoutData.difficulty] as Widget,
              const SizedBox(
                width: 5,
              ),
              Text(
                FormatUtils.toCapitalized(workoutData.difficulty.name),
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
          shrinkWrap: isSelfResource,
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
      if (workoutData.description == null || workoutData.description!.isEmpty) {
        return const SizedBox();
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InformationTag(
                  child: Text(
                    workoutData.description!,
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

    return StreamBuilder<WorkoutDetailsResponse>(
        initialData: WorkoutDetailsResponse.fromJson({
          "estimatedTimeInMinutes": 0,
          "totalSteps": 0,
        }),
        stream: generalStepsData,
        builder: (context, snapshot) {
          return DribbleLayout(
            popValue: workoutData,
            actions: [
              // Delete button
              renderAppBarButtons(snapshot.data!.totalSteps!),
            ],
            headerContent: Column(
              children: [
                // Title
                renderTitle(),

                // Time to complete
                renderDetail(
                  title: '${snapshot.data!.estimatedTimeInMinutes} mins',
                  icon: Icons.access_time_rounded,
                ),

                // Steps
                renderDetail(
                    title: '${snapshot.data!.totalSteps} Steps',
                    icon: Ionicons.footsteps),

                const SizedBox(
                  height: 8,
                ),

                // Edit workout button
                Visibility(
                  visible: isSelfResource,
                  child: ElevatedButton.icon(
                    onPressed: () => editWorkout(context),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit workout'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: onPrimaryContainer, elevation: 0),
                  ),
                ),
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
                      Visibility(
                        visible: isSelfResource,
                        child: InkWell(
                          onTap: () => addStep(context, CrudType.add),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // Renders all steps belongs with this workout
                  StepsPanelList(workoutSteps: stepsData),
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
        });
  }

  _showConfirmDeleteDialog(String title, int totalSteps) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: const Text("❌ Delete workout"),
        content: RichText(
          // Controls visual overflow
          overflow: TextOverflow.clip,

          // Controls how the text should be aligned horizontally
          textAlign: TextAlign.center,

          // Whether the text should break at soft line breaks
          softWrap: true,

          // The number of font pixels for each logical pixel
          textScaleFactor: 1,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: <TextSpan>[
              TextSpan(
                  text: '"$title"',
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
              const TextSpan(text: ' will be deleted. Are you sure?'),
              const TextSpan(text: "\nThis operation cannot be undone!"),
            ],
          ),
        ),
        actions: [
          BackButton(
            style: const ButtonStyle().copyWith(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
          ),
          ElevatedButton.icon(
            onPressed: () => deleteWorkout(context),
            style: const ButtonStyle().copyWith(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).primaryColorDark)),
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
