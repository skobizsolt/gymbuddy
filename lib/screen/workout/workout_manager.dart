import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/multiline_text_form_field.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/workout.dart';
import 'package:gymbuddy/screen/workout_steps/workout_step_manager.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';

class WorkoutManager extends StatefulWidget {
  WorkoutManager({super.key, required this.type});

  final CrudType type;

  @override
  State<WorkoutManager> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManager> {
  addStep(CrudType type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutStepManager(type: type),
      ),
    );
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            children: [
              const FormCategory(
                title: "Basic information",
                children: [
                  // Name of the workout
                  DefaultTextFormField(
                    hintText: "Title",
                  ),

                  // Details about the workout
                  MultiLineTextFormField(
                    hintText: "Describe your workout",
                    maxLines: 30,
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
              FormCategory(
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
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          style: ButtonStyle().copyWith(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColorDark),
                              surfaceTintColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColorDark)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
                value: e.name.toUpperCase(),
              ),
            )
            .toList(),
        value: WorkoutCategory.values[0].name.toUpperCase(),
        onChanged: (value) {},
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
                value: e.name.toUpperCase(),
              ),
            )
            .toList(),
        value: WorkoutDifficulty.values[0].name.toUpperCase(),
        onChanged: (value) {},
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
