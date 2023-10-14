import 'package:flutter/material.dart';

showConfirmDelete(BuildContext context,
    {Widget? title, Widget? subtitle, Function()? onTap}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: ListTile(
        title: title,
        subtitle: subtitle,
        trailing: Container(
          decoration: const BoxDecoration().copyWith(
            border: Border.all(
              width: 3,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(90),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: onTap,
          ),
        ),
      ),
    ),
  );
}
