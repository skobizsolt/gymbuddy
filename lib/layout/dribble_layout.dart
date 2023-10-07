import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/components/dribble_style_body.dart';

class DribbleLayout extends StatelessWidget {
  const DribbleLayout({
    super.key,
    this.addAppBar = true,
    this.actions,
    this.headerContent,
    this.body,
    this.footing,
    this.popValue,
  });

  final bool addAppBar;
  final List<Widget>? actions;
  final Widget? headerContent;
  final Widget? body;
  final Widget? footing;
  final dynamic popValue;

  @override
  Widget build(BuildContext context) {
    final headerColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    // Renders app bar buttons
    Widget renderAppBarButtons() {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            BackButton(
              style: ButtonStyle(
                iconColor: MaterialStatePropertyAll(
                  headerColor,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // Other actions
            Row(
              children: actions ?? [],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            addAppBar ? renderAppBarButtons() : const SizedBox(),

            const SizedBox(
              height: 8,
            ),

            // Basic details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: headerContent ?? const SizedBox(),
            ),

            const SizedBox(
              height: 25,
            ),
            DribbleBody(
              backgroundColor: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: body ?? const SizedBox(),
              ),
            ),

            // Footing
            footing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
