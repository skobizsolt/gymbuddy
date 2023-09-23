import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/multiline_text_form_field.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/workout/change_workout_step_request.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/service/validators.dart';

class WorkoutStepManager extends StatefulWidget {
  WorkoutStepManager({super.key, required this.type});

  final CrudType type;

  @override
  State<WorkoutStepManager> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutStepManager> {
  final ChangeWorkoutStepRequest _step = ChangeWorkoutStepRequest();
  final _formKey = GlobalKey<FormState>();

  _saveForm() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.pop(context, _step);
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
              "${widget.type.name[0].toUpperCase() + widget.type.name.substring(1)} workout step"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormCategory(
                    title: "Basic step information",
                    children: [
                      // Name of the workout
                      DefaultTextFormField(
                        hintText: "Step name",
                        onSaved: (value) => _step.stepName = value,
                      ),

                      // Details about the workout
                      MultiLineTextFormField(
                        hintText: "Step descriptions",
                        validator: (p0) {
                          return null;
                        },
                        maxLines: 30,
                        onSaved: (value) => _step.details = value,
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
                      DefaultTextFormField(
                        hintText: "Estimated time in seconds",
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            InputValidator().validateNumber(value),
                        onSaved: (value) =>
                            _step.estimatedTime = int.tryParse(value!),
                      ),
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
                  value: e.name,
                ),
              )
              .toList(),
          value: WorkoutType.values[0].name,
          onChanged: (value) {
            _step.workoutType = WorkoutType.values.byName(value!);
          },
          onSaved: (newValue) {
            _step.workoutType = WorkoutType.values.byName(newValue!);
          },
          decoration: const InputDecoration(border: InputBorder.none),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
