import 'package:hive/hive.dart';

/// Base class for all trackable items in the application.
///
/// This abstract class provides common fields and functionality for items
/// that need to be tracked, such as tasks, events, or habits.
@HiveType(typeId: 0)
abstract class TrackableItem extends HiveObject {
  /// Unique identifier for the trackable item
  @HiveField(0)
  final String id;

  /// Title or name of the trackable item
  @HiveField(1)
  final String title;

  /// Detailed description of the trackable item
  @HiveField(2)
  final String description;

  /// Timestamp when the item was created
  @HiveField(3)
  final DateTime createdAt;

  /// Timestamp when the item was last updated
  @HiveField(4)
  final DateTime updatedAt;

  /// Creates a new [TrackableItem] with the specified fields.
  ///
  /// All parameters are required to ensure proper tracking of the item.
  TrackableItem({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'TrackableItem{id: $id, title: $title, description: $description, '
        'createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackableItem &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
