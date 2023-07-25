import 'package:flutter/material.dart';

class Screen {
  Screen({
    required this.appBar,
    required this.body,
  });

  PreferredSizeWidget appBar;
  Widget body;
}
