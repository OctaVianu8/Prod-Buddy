import 'package:flutter/material.dart';
import '../features/tasks/presentation/pages/task_list_page.dart';
import '../features/tasks/presentation/pages/task_details_page.dart';
import '../features/tasks/presentation/pages/add_task_page.dart';

/// Application route definitions and navigation logic.
///
/// Centralizes all route names and generation logic for easier
/// navigation management and deep linking support.
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route name constants
  static const String taskList = '/';
  static const String taskDetails = '/task-details';
  static const String addTask = '/add-task';
  // TODO: Add more routes as features are developed
  // static const String settings = '/settings';
  // static const String calendar = '/calendar';

  /// Generate routes based on route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case taskList:
        return MaterialPageRoute(builder: (_) => const TaskListPage());

      case taskDetails:
        // TODO: Pass task ID or task object through settings.arguments
        final taskId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => TaskDetailsPage(taskId: taskId),
        );

      case addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskPage());

      // TODO: Add more route cases

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Route not found')),
          ),
        );
    }
  }

  /// Navigate to task details page
  static void navigateToTaskDetails(BuildContext context, String taskId) {
    Navigator.pushNamed(context, taskDetails, arguments: taskId);
  }

  /// Navigate to add task page
  static void navigateToAddTask(BuildContext context) {
    Navigator.pushNamed(context, addTask);
  }

  /// Navigate back
  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }
}
