import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/carousel/carousel_image.dart';

class MediaFormImage extends StatelessWidget {
  final Widget image;
  final void Function()? onDeleteItem;
  const MediaFormImage({
    super.key,
    required this.image,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CarouselImage(
            image: image,
          ),

          // Delete icon on top of image
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton.filled(
                color: Theme.of(context).colorScheme.errorContainer,
                style: const ButtonStyle().copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onErrorContainer)),
                onPressed: onDeleteItem,
                icon: const Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
