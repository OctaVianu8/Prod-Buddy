import '../../features/tasks/data/task_local_datasource.dart';
import '../../features/tasks/data/task_repository.dart';

/// Simple service locator for dependency injection.
///
/// Provides singleton instances of services throughout the app.
/// In a larger app, consider using Provider, Riverpod, or GetIt.
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator _instance = ServiceLocator._();
  static ServiceLocator get instance => _instance;

  TaskLocalDataSource? _taskLocalDataSource;
  TaskRepository? _taskRepository;

  /// Initialize all services
  Future<void> initialize() async {
    _taskLocalDataSource = TaskLocalDataSource();
    await _taskLocalDataSource!.initialize();

    _taskRepository = TaskRepository(localDataSource: _taskLocalDataSource!);
    await _taskRepository!.initialize();
  }

  /// Get TaskRepository instance
  TaskRepository get taskRepository {
    if (_taskRepository == null) {
      throw Exception(
        'ServiceLocator not initialized. Call initialize() first.',
      );
    }
    return _taskRepository!;
  }

  /// Get TaskLocalDataSource instance
  TaskLocalDataSource get taskLocalDataSource {
    if (_taskLocalDataSource == null) {
      throw Exception(
        'ServiceLocator not initialized. Call initialize() first.',
      );
    }
    return _taskLocalDataSource!;
  }

  /// Reset all services (useful for testing)
  Future<void> reset() async {
    await _taskLocalDataSource?.close();
    _taskLocalDataSource = null;
    _taskRepository = null;
  }
}
