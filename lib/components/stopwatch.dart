import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchWidget extends StatelessWidget {
  final StopWatchTimer stopWatchTimer;
  final double fontSize;
  const StopWatchWidget(
      {super.key, required this.stopWatchTimer, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(
          value ?? 0,
          milliSecond: false,
        );
        return Column(
          children: [
            Text(
              displayTime,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        );
      },
    );
  }
}
