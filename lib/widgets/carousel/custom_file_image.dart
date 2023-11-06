import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class CustomFileImage extends StatelessWidget {
  final File file;
  const CustomFileImage({super.key, required this.file});

  Image get fileImage => Image.file(
        width: double.infinity,
        fit: BoxFit.cover,
        File(file.path),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImageViewer(context, fileImage.image),
      child: fileImage,
    );
  }
}
