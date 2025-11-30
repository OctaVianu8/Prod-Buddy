import 'package:uuid/uuid.dart';

/// Service for generating unique identifiers for trackable items.
///
/// Uses UUID v4 for guaranteed uniqueness across devices and sessions.
/// This is crucial for offline-first architecture where items are created
/// locally before syncing to cloud.
class IdGenerator {
  static const Uuid _uuid = Uuid();

  /// Generate a new unique ID string.
  ///
  /// Returns a UUID v4 string that can be used as a primary key for tasks,
  /// events, or any other trackable items.
  static String generate() {
    return _uuid.v4();
  }

  /// Validate if a string is a valid UUID format.
  ///
  /// Returns true if [id] matches UUID format, false otherwise.
  static bool isValid(String id) {
    // Basic UUID v4 pattern check
    final uuidPattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidPattern.hasMatch(id);
  }
}
