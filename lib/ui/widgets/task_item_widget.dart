import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    this.color,
    required this.text,
  });
  final Color? color;
  final String text;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final chipTheme = Theme.of(context).chipTheme;
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(
          'Title will be here',
          style: textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description will be here', style: textTheme.titleSmall),
            Text('Date: 17/01/2025', style: textTheme.titleSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(text),
                  color: WidgetStateProperty.all(color),
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
}
