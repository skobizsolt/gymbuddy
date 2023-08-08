import 'package:flutter/material.dart';

class DribbleBody extends StatelessWidget {
  const DribbleBody({super.key, this.child, this.backgroundColor});

  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).primaryColorDark,
          ),
          child: child ?? const SizedBox(),
        ),
      ),
    );
  }
}
