import 'dart:convert';
import 'package:flutter/material.dart';

// Define the TaskStatus enum.
enum TaskStatus { newTask, progress, completed, cancel }

// Helper to map the JSON status string to TaskStatus enum.
TaskStatus getTaskStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'new':
      return TaskStatus.newTask;
    case 'progress':
      return TaskStatus.progress;
    case 'completed':
      return TaskStatus.completed;
    case 'cancel':
      return TaskStatus.cancel;
    default:
      return TaskStatus.newTask;
  }
}

class TaskCardStatusWidget extends StatelessWidget {
  const TaskCardStatusWidget({
    super.key,
    required this.title,
    required this.count,
    required this.status,
  });

  final String title;
  final String count;
  final TaskStatus status;

  // Determine background color based on task status.
  Color getBackgroundColor() {
    switch (status) {
      case TaskStatus.newTask:
        return Colors.blue.shade100;
      case TaskStatus.completed:
        return Colors.green.shade100;
      case TaskStatus.cancel:
        return Colors.red.shade100;
      case TaskStatus.progress:
        return Colors.orange.shade100;
    }
  }

  // Determine icon based on task status.
  IconData getStatusIcon() {
    switch (status) {
      case TaskStatus.newTask:
        return Icons.fiber_new;
      case TaskStatus.completed:
        return Icons.check_circle;
      case TaskStatus.cancel:
        return Icons.cancel;
      case TaskStatus.progress:
        return Icons.timelapse;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        color: getBackgroundColor(),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                getStatusIcon(),
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                count.toString(),

                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example widget that parses the JSON response and displays the cards.

