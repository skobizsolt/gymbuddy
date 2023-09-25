import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/multiline_text_form_field.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/models/workout/change_workout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/mapper/workout_internal_mapper.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/service/workout/workout_service.dart';
import 'package:gymbuddy/widgets/workout/steps_panel_list.dart';

class WorkoutManager extends StatefulWidget {
  WorkoutManager({super.key, required this.type, this.workout});

  final CrudType type;
  final Workout? workout;

  @override
  State<WorkoutManager> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManager> {
  late ChangeWorkoutDto _workout = ChangeWorkoutDto(
    steps: [],
  );
  final _formkey = GlobalKey<FormState>();

  _saveForm() async {
    var isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    if (CrudType.add == widget.type) {
      await WorkoutService().createWorkout(context, _workout);
    }
    if (CrudType.edit == widget.type) {
      await WorkoutService()
          .editWorkout(context, widget.workout!.workoutId, _workout)
          .then((value) => Navigator.of(context).pop(value));
    }
  }

  addStep(CrudType type) async {
    final ChangeWorkoutStepDto? addedStep = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(type: type),
      ),
    );
    if (addedStep == null) {
      return;
    }
    setState(() {
      _workout.steps.add(addedStep);
      print("Added step $addedStep");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardService().closeKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${widget.type.name[0].toUpperCase() + widget.type.name.substring(1)} workout"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  FormCategory(
                    title: "Basic information",
                    children: [
                      // Name of the workout
                      DefaultTextFormField(
                        initialValue: CrudType.edit == widget.type
                            ? widget.workout!.title
                            : null,
                        hintText: "Title",
                        onSaved: (value) => _workout.title = value,
                      ),

                      // Details about the workout
                      MultiLineTextFormField(
                        initialValue: CrudType.edit == widget.type
                            ? widget.workout!.description
                            : null,
                        hintText: "Describe your workout",
                        maxLines: 30,
                        validator: (p0) => null,
                        onSaved: (value) => _workout.description = value,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Workout categorization
                  FormCategory(
                    title: "Categorize your workout",
                    children: [
                      // Workout category dropdown
                      _buildWorkoutCategoryList(),

                      // Workout difficulty dropdown
                      _buildWorkoutDifficulty(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Add steps
                  CrudType.add == widget.type
                      ? FormCategory(
                          title: "Steps to complete this training",
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      addStep(CrudType.add);
                                    },
                                    icon: const Icon(Icons.add),
                                    label: Text(
                                      "Add step",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    style: const ButtonStyle().copyWith(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context).primaryColorDark),
                                      surfaceTintColor:
                                          MaterialStatePropertyAll(
                                              Theme.of(context)
                                                  .primaryColorDark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            renderSteps(),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _saveForm,
          icon: const Icon(
            Icons.save,
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          label: const Text("Save"),
        ),
      ),
    );
  }

  _buildWorkoutCategoryList() {
    return InputLayout(
      child: DropdownButtonFormField(
        items: WorkoutCategory.values
            .map(
              (e) => DropdownMenuItem(
                child: Text(
                    "${workoutCategoryIcon[e]} ${e.name[0].toUpperCase() + e.name.substring(1)}"),
                value: e.name,
              ),
            )
            .toList(),
        value: CrudType.edit == widget.type
            ? widget.workout!.category.name
            : WorkoutCategory.values[0].name,
        onChanged: (value) =>
            _workout.category = WorkoutCategory.values.byName(value!),
        onSaved: (newValue) =>
            _workout.category = WorkoutCategory.values.byName(newValue!),
        decoration: const InputDecoration(border: InputBorder.none),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  _buildWorkoutDifficulty() {
    return InputLayout(
      child: DropdownButtonFormField(
        items: WorkoutDifficulty.values
            .map(
              (e) => DropdownMenuItem(
                child: Row(children: [
                  workoutDifficultyRating[e] as Widget,
                  const SizedBox(
                    width: 8,
                  ),
                  Text("${e.name[0].toUpperCase() + e.name.substring(1)}")
                ]),
                value: e.name,
              ),
            )
            .toList(),
        value: CrudType.edit == widget.type
            ? widget.workout!.difficulty.name
            : WorkoutDifficulty.values[0].name,
        onChanged: (value) =>
            _workout.difficulty = WorkoutDifficulty.values.byName(value!),
        onSaved: (newValue) =>
            _workout.difficulty = WorkoutDifficulty.values.byName(newValue!),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  renderSteps() {
    if (_workout.steps.isEmpty) {
      return const SizedBox();
    } else {
      return StepsPanelList(
          workoutSteps:
              WorkoutInternalDataMapper().toWorkoutStepList(_workout.steps));
    }
  }
}
