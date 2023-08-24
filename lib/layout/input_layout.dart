import 'package:flutter/material.dart';

class InputLayout extends StatelessWidget {
  const InputLayout({super.key, this.color, this.child, this.height});

  final Color? color;
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Card(
        color: color ?? Theme.of(context).primaryColorDark,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: child,
        ),
      ),
    );
  }
}
