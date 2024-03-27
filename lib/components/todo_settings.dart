import 'package:flutter/material.dart';

class TodoSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  final void Function()? onCompleteTap;

  const TodoSettings({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onCompleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 30,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 30,
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onCompleteTap!();
          },
          child: Container(
            height: 30,
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                "Done",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
