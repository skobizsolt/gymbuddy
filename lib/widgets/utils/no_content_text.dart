import 'package:flutter/material.dart';

class NoContentText extends StatelessWidget {
  const NoContentText({
    super.key,
    required this.title,
    this.details,
  });

  final String title;
  final String? details;

  @override
  Widget build(BuildContext context) {
    Widget renderDetails() {
      if (details == null) {
        return const SizedBox();
      }
      return Text(details!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ));
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          renderDetails()
        ],
      ),
    );
  }
}