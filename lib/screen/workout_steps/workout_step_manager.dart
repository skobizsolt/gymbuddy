import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/multiline_text_form_field.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';

class WorkoutStepManager extends StatefulWidget {
  WorkoutStepManager({super.key, required this.type});

  final CrudType type;

  @override
  State<WorkoutStepManager> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutStepManager> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardService().closeKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${widget.type.name[0].toUpperCase() + widget.type.name.substring(1)} workout step"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: [
                const FormCategory(
                  title: "Basic step information",
                  children: [
                    // Name of the workout
                    DefaultTextFormField(
                      hintText: "Step name",
                    ),

                    // Details about the workout
                    MultiLineTextFormField(
                      hintText: "Describe your step",
                      maxLines: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // Workout categorization
                FormCategory(
                  title: "Details about this step",
                  children: [
                    const DefaultTextFormField(
                        hintText: "Estimated time in minutes"),
                    _buildWorkoutStepTypeList(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // Add media
                FormCategory(
                  title: "Pictures, illustrations",
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: Text(
                              "Add media",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            style: const ButtonStyle().copyWith(
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
      ),
    );
  }

  _buildWorkoutStepTypeList() {
    return InputLayout(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DropdownButtonFormField(
          items: WorkoutType.values
              .map(
                (e) => DropdownMenuItem(
                  child: Text(
                      "${e.name[0].toUpperCase() + e.name.substring(1)} based step"),
                  value: e.name.toUpperCase(),
                ),
              )
              .toList(),
          value: WorkoutType.values[0].name.toUpperCase(),
          onChanged: (value) {},
          decoration: const InputDecoration(border: InputBorder.none),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
