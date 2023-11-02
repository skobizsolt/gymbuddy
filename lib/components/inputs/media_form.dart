import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymbuddy/components/crud/form_category.dart';
import 'package:gymbuddy/widgets/utils/carousel_with_indicator.dart';
import 'package:image_picker/image_picker.dart';

class MultiMediaForm extends StatefulWidget {
  const MultiMediaForm({super.key});

  @override
  State<MultiMediaForm> createState() => _MultiMediaFormState();
}

class _MultiMediaFormState extends State<MultiMediaForm> {
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return FormCategory(
      title: "Pictures, illustrations",
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addImages,
                icon: const Icon(Icons.add),
                label: Text(
                  "Add media",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                style: const ButtonStyle().copyWith(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorDark),
                    surfaceTintColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorDark)),
              ),
            ),
          ],
        ),
        _buildImages(),
      ],
    );
  }

  _addImages() async {
    List<XFile> resultList = await ImagePicker().pickMultiImage();
    if (resultList.isEmpty) {
      return;
    }

    setState(() {
      resultList.forEach((element) {
        images.add(File(element.path));
      });
    });
  }

  _buildImages() {
    return images.isEmpty
        ? const SizedBox()
        // : GridView.count(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     crossAxisCount: 2,
        //     children: images
        //         .map((e) => Container(
        //               width: double.infinity,
        //               child: Image.file(
        //                 File(e.path),
        //               ),
        //             ))
        //         .toList(),
        //   );
        //       : Column(
        //           children: images
        //               .map((e) => Container(
        //                     width: double.infinity,
        //                     child: Image.file(
        //                       File(e.path),
        //                     ),
        //                   ))
        //               .toList(),
        //         );
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CarouselWithIndicator(images: _renderImages()),
          );
  }

  _renderImages() {
    return images
        .map(
          (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      File(e.path),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton.filled(
                          color: Theme.of(context).colorScheme.errorContainer,
                          style: const ButtonStyle().copyWith(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer)),
                          onPressed: () => _removeImage(e),
                          icon: const Icon(Icons.delete)),
                    )
                  ],
                ),
              )),
        )
        .toList();
  }

  _removeImage(File element) {
    setState(() {
      images.remove(element);
    });
  }
}
