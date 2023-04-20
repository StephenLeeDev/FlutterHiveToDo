import 'package:flutter/material.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/presentation/view/screen/update/update_task_screen.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.index,
    required this.task,
    required this.onDeleted,
    required this.onUpdated,
  }) : super(key: key);

  final int index;
  final TaskModel task;
  final Function onDeleted;
  final Function onUpdated;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary;
    final TaskModel item = widget.task;

    return Material(
      child: AnimatedContainer(
        constraints: const BoxConstraints(minHeight: 60),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: item.finished ? Colors.grey : evenItemColor,
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Row(
          children: [
            Checkbox(
              key: widget.key,
              value: item.finished,
              onChanged: (checked) {
                if (checked != null) {
                  widget.task.finished = checked;
                  widget.task.save();
                }
                setState(() {
                  item.finished = checked ?? false;
                });
              },
            ),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  decoration: item.finished
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () async {
                final isUpdated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTaskScreen(
                        index: widget.index, task: widget.task),
                  ),
                );
                if (isUpdated) {
                  widget.onUpdated();
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () => widget.onDeleted(),
            )
          ],
        ),
      ),
    );
  }
}
