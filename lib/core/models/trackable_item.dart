/// Base abstract class for all items that can be tracked in the app.
///
/// This includes tasks, events, reminders, and any future trackable entities.
/// Provides common properties like ID, title, description, and timestamps.
abstract class TrackableItem {
  /// Unique identifier for this item.
  final String id;

  /// Display title/name for this item.
  final String title;

  /// Optional detailed description.
  final String? description;

  /// When this item was created.
  final DateTime createdAt;

  /// Optional deadline for completion.
  final DateTime? deadline;

  /// When this item was last updated.
  final DateTime updatedAt;

  TrackableItem({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.deadline,
    required this.updatedAt,
  });

  /// Convert to a map for storage/serialization.
  /// Subclasses should override this and call super.toMap().
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create a copy with modified fields.
  /// Subclasses should override this with their specific type.
  TrackableItem copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? updatedAt,
  });
}
