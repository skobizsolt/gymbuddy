import 'package:flutter/material.dart';
import 'package:gymbuddy/data/workout_step_data.dart';
import 'package:gymbuddy/models/workout_step.dart';

class StepsPanelList extends StatefulWidget {
  const StepsPanelList({super.key, required this.workoutId});

  final int workoutId;

  @override
  State<StepsPanelList> createState() => _StepsPanelListState();
}

class _StepsPanelListState extends State<StepsPanelList> {
  List<WorkoutStep> get steps {
    List<WorkoutStep> list = stepsData
        .where(
          (element) => element.workoutId == widget.workoutId,
        )
        .toList();
    list.sort(
        (step, nextStep) => step.stepNumber.compareTo(nextStep.stepNumber));
    return list;
  }

  void showStepDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(steps[index].stepName),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
          content: Text(steps[index].details),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Option 1
    // return SingleChildScrollView(
    //   child: ExpansionPanelList(
    //     expandIconColor: Theme.of(context).colorScheme.primaryContainer,
    //     expandedHeaderPadding: EdgeInsets.all(8.0),
    //     animationDuration: const Duration(milliseconds: 300),
    //     expansionCallback: (index, bool isExpanded) {
    //       setState(
    //         () {
    //           print(
    //               'not $isExpanded is assigned to $index ${steps[index].expanded}');
    //           steps[index].expanded = !isExpanded;
    //         },
    //       );
    //     },
    //     children: steps.map<ExpansionPanel>((WorkoutStep step) {
    //       return ExpansionPanel(
    //           backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    //           isExpanded: step.expanded,
    //           headerBuilder: (context, isExpanded) {
    //             return ListTile(
    //               title: Text(step.stepName),
    //               textColor: Theme.of(context).colorScheme.primaryContainer,
    //             );
    //           },
    //           body: ListTile(
    //             title: Text(step.details),
    //           ));
    //     }).toList(),
    //   ),
    // );

    // Option 2
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            child: ListTile(
              title: Text(steps[index].stepName),
              subtitle: Text('Type: ${steps[index].workoutType.name}'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryContainer),
              trailing: IconButton(
                onPressed: () {
                  showStepDialog(index);
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
