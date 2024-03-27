import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/todo_settings.dart';
import 'package:popover/popover.dart';

class TodoTile extends StatelessWidget {
  final String text;
  final bool completed;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function()? onCompletePressed;

  const TodoTile({
    super.key,
    required this.text,
    required this.completed,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onCompletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            decoration: completed ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
              width: 100,
              height: 100,
              backgroundColor: Theme.of(context).colorScheme.background,
              context: context,
              bodyBuilder: (context) => TodoSettings(
                onEditTap: onEditPressed,
                onDeleteTap: onDeletePressed,
                onCompleteTap: onCompletePressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
