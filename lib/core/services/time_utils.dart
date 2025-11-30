import 'package:intl/intl.dart';

/// Utility functions for time-related operations.
///
/// Provides helpers for formatting dates, calculating time differences,
/// and computing urgency based on deadlines.
class TimeUtils {
  /// Format a DateTime to a human-readable string.
  ///
  /// Example: "Jan 15, 2024 3:30 PM"
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y h:mm a').format(dateTime);
  }

  /// Format a DateTime to a short date string.
  ///
  /// Example: "Jan 15, 2024"
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime);
  }

  /// Format a DateTime to a time-only string.
  ///
  /// Example: "3:30 PM"
  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  /// Calculate how many days are left until a deadline.
  ///
  /// Returns positive number for future dates, negative for past dates.
  /// Returns null if [deadline] is null.
  static int? daysUntil(DateTime? deadline) {
    if (deadline == null) return null;
    final now = DateTime.now();
    final difference = deadline.difference(now);
    return difference.inDays;
  }

  /// Get a human-readable representation of time remaining.
  ///
  /// Examples: "2 days left", "5 hours left", "Overdue by 3 days"
  static String timeRemainingString(DateTime? deadline) {
    if (deadline == null) return 'No deadline';

    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      final overdueDays = difference.inDays.abs();
      if (overdueDays == 0) return 'Overdue';
      return 'Overdue by $overdueDays ${overdueDays == 1 ? 'day' : 'days'}';
    }

    final days = difference.inDays;
    if (days > 0) {
      return '$days ${days == 1 ? 'day' : 'days'} left';
    }

    final hours = difference.inHours;
    if (hours > 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'} left';
    }

    final minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} left';
  }

  /// Check if a deadline is overdue.
  static bool isOverdue(DateTime? deadline) {
    if (deadline == null) return false;
    return deadline.isBefore(DateTime.now());
  }

  /// Check if a deadline is within the next 24 hours.
  static bool isDueSoon(DateTime? deadline) {
    if (deadline == null) return false;
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(hours: 24));
    return deadline.isAfter(now) && deadline.isBefore(tomorrow);
  }

  /// Convert minutes to a human-readable duration string.
  ///
  /// Examples: "2h 30m", "45m", "3h"
  static String formatDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${remainingMinutes}m';
  }

  /// Calculate urgency score based on deadline proximity and priority.
  ///
  /// Returns a score from 0.0 to 1.0 where 1.0 is most urgent.
  /// TODO: Fine-tune the urgency formula based on user feedback.
  static double calculateUrgency({
    required int priority,
    DateTime? deadline,
    int? estimatedTime,
  }) {
    // Base urgency from priority (1-4 maps to 0.25-1.0)
    double urgency = priority / 4.0;

    // Boost urgency if deadline is approaching
    if (deadline != null) {
      final daysLeft = daysUntil(deadline);
      if (daysLeft != null) {
        if (daysLeft < 0) {
          urgency = 1.0; // Overdue = maximum urgency
        } else if (daysLeft <= 1) {
          urgency = (urgency + 0.8) / 2; // Due today/tomorrow
        } else if (daysLeft <= 3) {
          urgency = (urgency + 0.6) / 2; // Due within 3 days
        } else if (daysLeft <= 7) {
          urgency = (urgency + 0.4) / 2; // Due within a week
        }
      }
    }

    return urgency.clamp(0.0, 1.0);
  }
}
