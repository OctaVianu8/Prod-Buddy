import 'package:flutter/material.dart';
import '../../../../core/models/task.dart';
import '../../../../core/services/time_utils.dart';
import 'priority_indicator.dart';

/// Reusable card widget for displaying task summary in lists.
///
/// Shows key task information: title, priority, deadline, completion status.
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Completion checkbox
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) => onToggleComplete?.call(),
              ),
              const SizedBox(width: 12),

              // Task content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Deadline info
                    if (task.deadline != null)
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: TimeUtils.isOverdue(task.deadline)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            TimeUtils.timeRemainingString(task.deadline),
                            style: TextStyle(
                              fontSize: 12,
                              color: TimeUtils.isOverdue(task.deadline)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),

                    // TODO: Add category tag if present
                    // TODO: Add estimated time display
                  ],
                ),
              ),

              // Priority indicator
              PriorityIndicator(priority: task.priority),
            ],
          ),
        ),
      ),
    );
  }
}
