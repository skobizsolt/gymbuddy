import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage({super.key, required this.url});

  Image get networkImage => Image.network(
        width: double.infinity,
        fit: BoxFit.cover,
        url,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImageViewer(context, networkImage.image),
      child: networkImage,
    );
  }
}
