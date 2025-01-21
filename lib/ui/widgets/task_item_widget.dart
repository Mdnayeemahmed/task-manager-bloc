import 'package:flutter/material.dart';
import 'package:task_manager_ostad/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final chipTheme = Theme.of(context).chipTheme;
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(
          taskModel.title ?? '',
          style: textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? '', style: textTheme.titleSmall),
            Text('Date: ${taskModel.createdDate ?? ''}',
                style: textTheme.titleSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    taskModel.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getStatusColor(taskModel.status ?? 'New'),
                  side: BorderSide.none,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.cyan,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'New') {
      return Colors.cyan;
    } else if (status == 'Progress') {
      return Colors.purple;
    } else if (status == 'Completed') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
