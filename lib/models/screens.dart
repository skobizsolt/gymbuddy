import 'package:flutter/material.dart';

class Screen {
  Screen({
    this.appBar,
    required this.body,
  });

  PreferredSizeWidget? appBar;
  Widget body;
}
