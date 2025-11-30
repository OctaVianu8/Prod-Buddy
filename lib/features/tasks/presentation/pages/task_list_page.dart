import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
import '../../../../core/models/task.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/task_repository.dart';

/// Main page displaying the list of all tasks.
///
/// Shows tasks with sorting/filtering options and provides
/// navigation to add new tasks or view task details.
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late TaskRepository _repository;
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _repository = ServiceLocator.instance.taskRepository;
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasksFuture = _repository.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          // TODO: Add sorting/filtering menu
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show sort/filter options
            },
          ),
          // TODO: Add settings/sync button
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show menu (settings, sync, etc.)
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO: Add statistics card showing completion rate, overdue tasks, etc.

          // TODO: Add filter chips (All, Active, Completed)

          // Task list
          Expanded(child: _buildTaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRoutes.navigateToAddTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadTasks,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final tasks = snapshot.data ?? [];

        // Empty state
        if (tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet.\nTap + to add your first task!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Task list
        return ListView.builder(
          itemCount: tasks.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return _buildTaskCard(task);
          },
        );
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => _toggleTaskComplete(task.id),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (task.deadline != null || task.estimatedDuration != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    if (task.deadline != null) ...[
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        _formatDeadline(task.deadline!),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (task.estimatedDuration != null) ...[
                      const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${task.estimatedDuration}h',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
        trailing: _buildPriorityBadge(task.priority),
        onTap: () {
          // TODO: Navigate to task details
          // AppRoutes.navigateToTaskDetails(context, task.id);
        },
      ),
    );
  }

  Widget _buildPriorityBadge(int priority) {
    final colors = {
      1: Colors.blue,
      2: Colors.green,
      3: Colors.orange,
      4: Colors.deepOrange,
      5: Colors.red,
    };

    final labels = {
      1: 'Low',
      2: 'Low',
      3: 'Med',
      4: 'High',
      5: 'High',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[priority]?.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors[priority] ?? Colors.grey),
      ),
      child: Text(
        labels[priority] ?? 'Med',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: colors[priority],
        ),
      ),
    );
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[deadline.month - 1]} ${deadline.day}';
    }
  }

  Future<void> _toggleTaskComplete(String taskId) async {
    try {
      await _repository.toggleTaskCompletion(taskId);
      _loadTasks(); // Reload tasks to show updated state
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating task: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
