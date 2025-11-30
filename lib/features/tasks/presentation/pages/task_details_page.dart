import 'package:flutter/material.dart';
// import '../../../../core/models/task.dart';
// import '../../domain/task_usecases.dart';

/// Page for viewing and editing a single task's details.
class TaskDetailsPage extends StatefulWidget {
  final String? taskId;

  const TaskDetailsPage({super.key, required this.taskId});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  // TODO: Inject TaskUseCases
  // TODO: Load task data by ID

  @override
  void initState() {
    super.initState();
    // TODO: Fetch task details using widget.taskId
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual task loading
    // TODO: Handle loading, error, and not-found states

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          // TODO: Add edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit mode or inline editing
            },
          ),
          // TODO: Add delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Show confirmation dialog and delete task
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildTaskDetails(),
      ),
    );
  }

  Widget _buildTaskDetails() {
    // TODO: Load and display actual task data
    // TODO: Show all task fields (title, description, priority, deadline, etc.)
    // TODO: Make fields editable or navigate to edit page

    return const Center(child: Text('Task details will appear here'));

    // Future implementation:
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(task.title, style: Theme.of(context).textTheme.displayLarge),
    //     const SizedBox(height: 16),
    //     PriorityIndicator(priority: task.priority),
    //     const SizedBox(height: 16),
    //     if (task.deadline != null)
    //       Row(
    //         children: [
    //           const Icon(Icons.calendar_today),
    //           const SizedBox(width: 8),
    //           Text(TimeUtils.formatDateTime(task.deadline!)),
    //         ],
    //       ),
    //     const SizedBox(height: 16),
    //     Text(task.description),
    //     // TODO: Add more fields
    //   ],
    // );
  }
}
