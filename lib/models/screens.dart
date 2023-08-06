import 'package:flutter/material.dart';

class Screen {
  Screen({
    this.appBar,
    required this.body,
    this.backgroundColor,
  });

  PreferredSizeWidget? appBar;
  Widget body;
  Color? backgroundColor;
}
