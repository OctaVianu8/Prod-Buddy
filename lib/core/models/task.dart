import 'package:hive/hive.dart';
import 'trackable_item.dart';

part 'task.g.dart'; // Generated file for Hive adapter

/// Represents a task with priority, estimation, and completion tracking.
///
/// Extends [TrackableItem] to add task-specific properties like priority level,
/// estimated duration, and completion status.
@HiveType(typeId: 0)
class Task extends TrackableItem {
  /// Priority level: 1 (low), 2 (medium), 3 (high), 4 (urgent).
  @HiveField(0)
  final int priority;

  /// Estimated time to complete this task (in minutes).
  @HiveField(1)
  final int? estimatedTime;

  /// Whether this task has been completed.
  @HiveField(2)
  final bool isCompleted;

  /// Optional category/tag for grouping tasks.
  @HiveField(3)
  final String? category;

  /// When the task was completed (null if not completed).
  @HiveField(4)
  final DateTime? completedAt;

  Task({
    required super.id,
    required super.title,
    super.description,
    required super.createdAt,
    super.deadline,
    required super.updatedAt,
    this.priority = 2, // Default to medium priority
    this.estimatedTime,
    this.isCompleted = false,
    this.category,
    this.completedAt,
  });

  /// Create a Task from a map (e.g., from Hive or JSON).
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      deadline: map['deadline'] != null
          ? DateTime.parse(map['deadline'] as String)
          : null,
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      priority: map['priority'] as int? ?? 2,
      estimatedTime: map['estimatedTime'] as int?,
      isCompleted: map['isCompleted'] as bool? ?? false,
      category: map['category'] as String?,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'priority': priority,
      'estimatedTime': estimatedTime,
      'isCompleted': isCompleted,
      'category': category,
      'completedAt': completedAt?.toIso8601String(),
    });
    return map;
  }

  @override
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? updatedAt,
    int? priority,
    int? estimatedTime,
    bool? isCompleted,
    String? category,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Compute urgency score based on priority, deadline, and estimated time.
  /// Higher score = more urgent.
  /// TODO: Implement urgency calculation logic in task_usecases.dart
  double get urgencyScore {
    // Placeholder - actual implementation should be in usecases
    return priority.toDouble();
  }
}
