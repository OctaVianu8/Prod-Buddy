import 'package:hive/hive.dart';
import 'trackable_item.dart';

/// Represents a task with deadline, estimated duration, priority, and completion status.
///
/// Extends [TrackableItem] to add task-specific properties like priority level (1-5),
/// estimated duration (in hours), completion status, and optional Google Calendar event integration.
@HiveType(typeId: 1)
class Task extends TrackableItem {
  /// Optional deadline for when this task should be completed
  @HiveField(5)
  final DateTime? deadline;

  /// Estimated duration to complete this task (in hours)
  @HiveField(6)
  final double? estimatedDuration;

  /// Priority level from 1 (lowest) to 5 (highest)
  @HiveField(7)
  final int priority;

  /// Whether this task has been marked as completed
  @HiveField(8)
  final bool isCompleted;

  /// Optional Google Calendar event ID for synced tasks
  @HiveField(9)
  final String? googleEventId;

  /// Creates a new [Task] with the specified fields.
  ///
  /// Parameters from [TrackableItem] (id, title, createdAt, updatedAt) are required.
  /// Description and task-specific fields like deadline and estimatedDuration are optional.
  /// Priority defaults to 3 (medium) and isCompleted defaults to false.
  Task({
    required super.id,
    required super.title,
    super.description,
    required super.createdAt,
    required super.updatedAt,
    this.deadline,
    this.estimatedDuration,
    this.priority = 3,
    this.isCompleted = false,
    this.googleEventId,
  }) : assert(
         priority >= 1 && priority <= 5,
         'Priority must be between 1 and 5',
       );

  /// Creates a copy of this task with the specified fields replaced.
  ///
  /// Any field not provided will retain its current value.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deadline,
    double? estimatedDuration,
    int? priority,
    bool? isCompleted,
    String? googleEventId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deadline: deadline ?? this.deadline,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      googleEventId: googleEventId ?? this.googleEventId,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, '
        'createdAt: $createdAt, updatedAt: $updatedAt, '
        'deadline: $deadline, estimatedDuration: $estimatedDuration, '
        'priority: $priority, isCompleted: $isCompleted, '
        'googleEventId: $googleEventId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deadline == deadline &&
        other.estimatedDuration == estimatedDuration &&
        other.priority == priority &&
        other.isCompleted == isCompleted &&
        other.googleEventId == googleEventId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deadline.hashCode ^
        estimatedDuration.hashCode ^
        priority.hashCode ^
        isCompleted.hashCode ^
        googleEventId.hashCode;
  }
}
