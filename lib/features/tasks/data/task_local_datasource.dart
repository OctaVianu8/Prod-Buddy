import 'package:hive/hive.dart';
import '../../../core/models/task.dart';

/// Local data source for tasks using Hive.
///
/// Handles CRUD operations for tasks in local storage.
/// This is the single source of truth for offline data.
class TaskLocalDataSource {
  static const String _boxName = 'tasks';
  late Box<Task> _taskBox;

  /// Initialize the Hive box for tasks.
  /// Must be called before any other operations.
  Future<void> initialize() async {
    _taskBox = await Hive.openBox<Task>(_boxName);
    // TODO: Consider error handling for box opening failures
  }

  /// Get all tasks from local storage.
  Future<List<Task>> getAllTasks() async {
    return _taskBox.values.toList();
  }

  /// Get a single task by ID.
  Future<Task?> getTaskById(String id) async {
    return _taskBox.get(id);
  }

  /// Add a new task to local storage.
  Future<void> addTask(Task task) async {
    // TODO: Implement add logic
    // Use task ID as the key for easy lookups
    await _taskBox.put(task.id, task);
  }

  /// Update an existing task.
  Future<void> updateTask(Task task) async {
    // TODO: Implement update logic
    // Verify task exists before updating
    if (!_taskBox.containsKey(task.id)) {
      throw Exception('Task not found');
    }
    await _taskBox.put(task.id, task);
  }

  /// Delete a task by ID.
  Future<void> deleteTask(String id) async {
    // TODO: Implement delete logic
    await _taskBox.delete(id);
  }

  /// Delete all tasks (useful for testing or reset).
  Future<void> deleteAllTasks() async {
    // TODO: Implement bulk delete
    await _taskBox.clear();
  }

  /// Stream of all tasks for reactive updates.
  Stream<List<Task>> watchAllTasks() {
    // TODO: Implement stream that emits whenever tasks change
    // This enables reactive UI updates
    return _taskBox.watch().map((_) => _taskBox.values.toList());
  }

  /// Close the Hive box (call on app disposal).
  Future<void> close() async {
    await _taskBox.close();
  }
}
