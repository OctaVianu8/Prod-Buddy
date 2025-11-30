import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';

/// Main entry point for the Prod Buddy application.
///
/// Initializes Hive for local storage and launches the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters for custom types
  // TODO: Uncomment after running build_runner to generate task.g.dart
  // Hive.registerAdapter(TaskAdapter());

  // TODO: Initialize other services (analytics, crash reporting, etc.)

  runApp(const ProdBuddyApp());
}
