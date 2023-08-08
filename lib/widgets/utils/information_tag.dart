import 'package:flutter/material.dart';

class InformationTag extends StatelessWidget {
  const InformationTag({super.key, this.color, this.child, this.margin});

  final Color? color;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).primaryColorLight;

    return Padding(
      padding: margin ?? const EdgeInsets.all(0.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? backgroundColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: color ?? backgroundColor,
        ),
        child: child ?? const SizedBox(),
      ),
    );
  }
}
