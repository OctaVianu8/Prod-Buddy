import '../../../core/models/task.dart';
import 'task_local_datasource.dart';
// import '../../../integrations/google_calendar/calendar_service.dart'; // Future

/// Repository for task data operations.
///
/// Abstracts the data layer by coordinating between local storage
/// and future cloud sync (Google Calendar). Implements offline-first
/// architecture where local data is the source of truth.
class TaskRepository {
  final TaskLocalDataSource _localDataSource;
  // final CalendarService _calendarService; // TODO: Add when implementing sync

  TaskRepository({
    required TaskLocalDataSource localDataSource,
    // CalendarService? calendarService, // TODO: Inject calendar service
  }) : _localDataSource = localDataSource;

  /// Initialize the repository and underlying data sources.
  Future<void> initialize() async {
    await _localDataSource.initialize();
    // TODO: Initialize calendar service connection
  }

  /// Get all tasks.
  ///
  /// Returns tasks from local storage. In the future, this will:
  /// 1. Return local tasks immediately
  /// 2. Sync with Google Calendar in the background
  /// 3. Merge and resolve conflicts
  Future<List<Task>> getAllTasks() async {
    final tasks = await _localDataSource.getAllTasks();
    // TODO: Implement background sync with Google Calendar
    // TODO: Merge with calendar events
    return tasks;
  }

  /// Get a task by ID.
  Future<Task?> getTaskById(String id) async {
    return await _localDataSource.getTaskById(id);
  }

  /// Create a new task.
  ///
  /// Saves to local storage first, then syncs to cloud.
  /// This ensures offline functionality.
  Future<void> createTask(Task task) async {
    // Save locally first (offline-first)
    await _localDataSource.addTask(task);

    // TODO: Queue for sync to Google Calendar
    // TODO: Handle sync failures and retry logic
  }

  /// Update an existing task.
  Future<void> updateTask(Task task) async {
    await _localDataSource.updateTask(task);

    // TODO: Queue for sync to Google Calendar
    // TODO: Implement conflict resolution if cloud version differs
  }

  /// Delete a task.
  Future<void> deleteTask(String id) async {
    await _localDataSource.deleteTask(id);

    // TODO: Queue deletion for Google Calendar sync
  }

  /// Toggle task completion status.
  ///
  /// Convenience method for marking tasks as done/undone.
  Future<void> toggleTaskCompletion(String id) async {
    final task = await getTaskById(id);
    if (task == null) return;

    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );

    await updateTask(updatedTask);
  }

  /// Stream of all tasks for reactive UI updates.
  Stream<List<Task>> watchAllTasks() {
    return _localDataSource.watchAllTasks();
  }

  /// Sync local tasks with Google Calendar.
  ///
  /// TODO: Implement full bidirectional sync logic:
  /// - Upload local changes to Calendar
  /// - Download Calendar changes
  /// - Resolve conflicts (last-write-wins, custom merge, etc.)
  /// - Handle network failures gracefully
  Future<void> syncWithCalendar() async {
    // TODO: Implement sync logic
    throw UnimplementedError('Calendar sync not yet implemented');
  }

  /// Clear all local data (useful for logout/reset).
  Future<void> clearAllData() async {
    await _localDataSource.deleteAllTasks();
  }
}
