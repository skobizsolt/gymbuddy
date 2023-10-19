import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/components/dribble_style_body.dart';

class DribbleLayout extends StatelessWidget {
  const DribbleLayout({
    super.key,
    this.addAppBar = true,
    this.addBackButton = true,
    this.actions,
    this.headerContent,
    this.body,
    this.footing,
  });

  final bool addAppBar;
  final List<Widget>? actions;
  final bool addBackButton;
  final Widget? headerContent;
  final Widget? body;
  final Widget? footing;

  @override
  Widget build(BuildContext context) {
    final headerColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    // Renders app bar buttons
    _renderAppBarButtons() {
      return addAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: addBackButton,
              actions: actions,
              foregroundColor: headerColor,
            )
          : null;
    }

    _renderContent() {
      return Column(
        children: [
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
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: _renderAppBarButtons(),
      body: addAppBar
          ? _renderContent()
          : SafeArea(
              child: _renderContent(),
            ),
    );
  }
}
