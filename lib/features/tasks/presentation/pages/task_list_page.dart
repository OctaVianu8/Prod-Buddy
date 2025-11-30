import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
// import '../../domain/task_usecases.dart';
// import '../widgets/task_card.dart';

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
  // TODO: Inject TaskUseCases via provider/dependency injection
  // TODO: Implement state management (Provider, Riverpod, Bloc, etc.)

  @override
  void initState() {
    super.initState();
    // TODO: Load tasks on initialization
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
    // TODO: Replace with actual task loading from repository
    // TODO: Handle loading, empty, and error states
    // TODO: Use ListView.builder with TaskCard widgets

    return const Center(
      child: Text(
        'No tasks yet.\nTap + to add your first task!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );

    // Future implementation:
    // return ListView.builder(
    //   itemCount: tasks.length,
    //   itemBuilder: (context, index) {
    //     final task = tasks[index];
    //     return TaskCard(
    //       task: task,
    //       onTap: () => AppRoutes.navigateToTaskDetails(context, task.id),
    //       onToggleComplete: () => _toggleTaskComplete(task.id),
    //     );
    //   },
    // );
  }

  // TODO: Implement task completion toggle
  // Future<void> _toggleTaskComplete(String taskId) async {
  //   await _taskUseCases.repository.toggleTaskCompletion(taskId);
  //   setState(() {}); // Or use state management
  // }
}
