import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/media_form.dart';
import 'package:gymbuddy/components/inputs/multiline_text_form_field.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/workout/change_workout_step.dart';
import 'package:gymbuddy/models/workout_image.dart';
import 'package:gymbuddy/models/workout_step.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/service/util/format_utils.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/service/workout/workout_step_media_service.dart';
import 'package:gymbuddy/widgets/utils/save_icon.dart';

class WorkoutStepManager extends ConsumerStatefulWidget {
  WorkoutStepManager({
    super.key,
    required this.type,
    required this.workoutId,
    this.workoutStep,
    this.stepPosition,
    this.images,
  });

  final CrudType type;
  final int workoutId;
  final WorkoutStep? workoutStep;
  final int? stepPosition;
  final List<WorkoutImage>? images;

  @override
  ConsumerState<WorkoutStepManager> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends ConsumerState<WorkoutStepManager> {
  final _mediaService = WorkoutStepMediaService();
  final ChangeWorkoutStepDto _step = ChangeWorkoutStepDto();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  late final List<WorkoutImage> localImages;

  int? get currentEstimatedTime {
    return CrudType.edit == widget.type
        ? widget.workoutStep!.estimatedTime
        : _step.estimatedTime;
  }

  @override
  initState() {
    super.initState();
    _step.estimatedTime = currentEstimatedTime ?? 0;
    localImages = widget.images ?? [];
  }

  _saveForm() async {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isSaving = true;
    });
    KeyboardService.closeKeyboard();
    await performOperation().whenComplete(
      () {
        setState(() {
          _isSaving = false;
        });
      },
    );
  }

  Future<void> performOperation() async {
    switch (widget.type) {
      case CrudType.edit:
        try {
          await ref
              .read(workoutStepStateProvider.notifier)
              .editStep(
                  workoutId: widget.workoutId,
                  stepPosition: widget.stepPosition!,
                  editedStep: _step)
              .then((value) =>
                  showSuccessSnackBar(context, "Step edited successfully!"));
          Navigator.of(context).pop();
        } on Exception {
          showErrorSnackBar(
              context, "Failed to save changes, please try again later!");
        }
        break;
      case CrudType.add:
        try {
          await ref
              .read(workoutStepStateProvider.notifier)
              .createStep(widget.workoutId, _step)
              .then((value) => value != null
                  ? _mediaService.saveImages(
                      localImages, widget.workoutId, value)
                  : null)
              .then((value) => showSuccessSnackBar(context, "New step added!"));
          Navigator.of(context).pop();
        } on Exception {
          showErrorSnackBar(
              context, "Failed to add this step, please try again later!");
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: KeyboardService.closeKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${FormatUtils.toCapitalized(widget.type.name)} workout step"),
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
                        initialValue: CrudType.edit == widget.type
                            ? widget.workoutStep!.stepName
                            : null,
                        onSaved: (value) => _step.stepName = value,
                      ),

                      // Details about the workout
                      MultiLineTextFormField(
                        hintText: "Step descriptions",
                        initialValue: CrudType.edit == widget.type
                            ? widget.workoutStep!.details
                            : null,
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
                      _buildTimePicker(),
                      _buildWorkoutStepTypeList(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Add media
                  WorkoutMediaForm(
                    images: localImages,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SaveButton(
          onPressed: _saveForm,
          isSaving: _isSaving,
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
                  child:
                      Text("${FormatUtils.toCapitalized(e.name)} based step"),
                  value: e.name,
                ),
              )
              .toList(),
          value: CrudType.edit == widget.type
              ? widget.workoutStep!.workoutType.name
              : WorkoutType.values[0].name,
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

  _buildTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              // Controls visual overflow
              overflow: TextOverflow.clip,

              // Whether the text should break at soft line breaks
              softWrap: true,

              // The number of font pixels for each logical pixel
              textScaleFactor: 1,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                      text: 'Estimated time:\n',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  TextSpan(
                    text: FormatUtils.toTimeString(
                        Duration(seconds: _step.estimatedTime ?? 0)),
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text("Select time")),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedDuration = await showDurationPicker(
      context: context,
      initialTime: Duration(seconds: _step.estimatedTime ?? 30),
      baseUnit: BaseUnit.second,
    );
    if (pickedDuration != null) {
      setState(() {
        _step.estimatedTime = pickedDuration.inSeconds;
      });
    }
  }
}
