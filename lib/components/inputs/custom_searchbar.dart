import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.height,
    this.color,
    this.onChanged,
  });
  final double? height;
  final Color? color;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SearchBar(
        onChanged: onChanged,
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        leading: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'Search',
        backgroundColor: MaterialStatePropertyAll(
          color ?? Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
