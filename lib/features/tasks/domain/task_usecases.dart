import '../../../core/models/task.dart';
import '../../../core/services/time_utils.dart';
import '../data/task_repository.dart';
// import '../../../integrations/gemini/gemini_service.dart'; // Future

/// Business logic and use cases for task management.
///
/// Centralizes operations like sorting, filtering, urgency calculation,
/// and future AI-powered suggestions from Gemini.
class TaskUseCases {
  final TaskRepository _repository;
  // final GeminiService _geminiService; // TODO: Add when implementing AI features

  TaskUseCases({
    required TaskRepository repository,
    // GeminiService? geminiService, // TODO: Inject Gemini service
  }) : _repository = repository;

  /// Get all tasks sorted by urgency (most urgent first).
  Future<List<Task>> getTasksSortedByUrgency() async {
    final tasks = await _repository.getAllTasks();

    // TODO: Use TimeUtils.calculateUrgency for each task
    tasks.sort((a, b) {
      final urgencyA = TimeUtils.calculateUrgency(
        priority: a.priority,
        deadline: a.deadline,
        estimatedTime: a.estimatedDuration,
      );
      final urgencyB = TimeUtils.calculateUrgency(
        priority: b.priority,
        deadline: b.deadline,
        estimatedTime: b.estimatedDuration,
      );
      return urgencyB.compareTo(urgencyA); // Descending order
    });

    return tasks;
  }

  /// Get tasks sorted by deadline (soonest first).
  Future<List<Task>> getTasksSortedByDeadline() async {
    final tasks = await _repository.getAllTasks();

    tasks.sort((a, b) {
      if (a.deadline == null && b.deadline == null) return 0;
      if (a.deadline == null) return 1; // Tasks without deadlines go last
      if (b.deadline == null) return -1;
      return a.deadline!.compareTo(b.deadline!);
    });

    return tasks;
  }

  /// Get tasks sorted by priority (highest first).
  Future<List<Task>> getTasksSortedByPriority() async {
    final tasks = await _repository.getAllTasks();
    tasks.sort((a, b) => b.priority.compareTo(a.priority));
    return tasks;
  }

  /// Get only incomplete tasks.
  Future<List<Task>> getIncompleteTasks() async {
    final tasks = await _repository.getAllTasks();
    return tasks.where((task) => !task.isCompleted).toList();
  }

  /// Get only completed tasks.
  Future<List<Task>> getCompletedTasks() async {
    final tasks = await _repository.getAllTasks();
    return tasks.where((task) => task.isCompleted).toList();
  }

  /// Get tasks due today.
  Future<List<Task>> getTasksDueToday() async {
    final tasks = await _repository.getAllTasks();
    final now = DateTime.now();

    return tasks.where((task) {
      if (task.deadline == null) return false;
      final deadline = task.deadline!;
      return deadline.year == now.year &&
          deadline.month == now.month &&
          deadline.day == now.day;
    }).toList();
  }

  /// Get overdue tasks.
  Future<List<Task>> getOverdueTasks() async {
    final tasks = await _repository.getAllTasks();
    return tasks.where((task) => TimeUtils.isOverdue(task.deadline)).toList();
  }

  /// Search tasks by title or description.
  Future<List<Task>> searchTasks(String query) async {
    final tasks = await _repository.getAllTasks();
    final lowerQuery = query.toLowerCase();

    return tasks.where((task) {
      final titleMatch = task.title.toLowerCase().contains(lowerQuery);
      final descMatch = task.description.toLowerCase().contains(lowerQuery);
      return titleMatch || descMatch;
    }).toList();
  }

  /// Get AI-powered scheduling suggestions from Gemini.
  ///
  /// TODO: Implement Gemini integration:
  /// - Send task list and user preferences to Gemini
  /// - Request optimal scheduling suggestions
  /// - Return suggested deadlines and priorities
  /// - Consider user's calendar availability
  Future<List<String>> getSchedulingSuggestions(Task task) async {
    // TODO: Implement Gemini API integration
    throw UnimplementedError('Gemini suggestions not yet implemented');

    // Future implementation:
    // final suggestions = await _geminiService.getSuggestions(task);
    // return suggestions;
  }

  /// Compute task statistics (total, completed, pending, etc.).
  Future<TaskStatistics> getStatistics() async {
    final tasks = await _repository.getAllTasks();

    return TaskStatistics(
      totalTasks: tasks.length,
      completedTasks: tasks.where((t) => t.isCompleted).length,
      incompleteTasks: tasks.where((t) => !t.isCompleted).length,
      overdueTasks: tasks.where((t) => TimeUtils.isOverdue(t.deadline)).length,
      tasksDueToday: tasks.where((t) {
        if (t.deadline == null) return false;
        final now = DateTime.now();
        return t.deadline!.year == now.year &&
            t.deadline!.month == now.month &&
            t.deadline!.day == now.day;
      }).length,
    );
  }
}

/// Statistics about tasks.
class TaskStatistics {
  final int totalTasks;
  final int completedTasks;
  final int incompleteTasks;
  final int overdueTasks;
  final int tasksDueToday;

  TaskStatistics({
    required this.totalTasks,
    required this.completedTasks,
    required this.incompleteTasks,
    required this.overdueTasks,
    required this.tasksDueToday,
  });

  double get completionRate {
    if (totalTasks == 0) return 0.0;
    return completedTasks / totalTasks;
  }
}
