import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';
import 'core/models/task.dart';
import 'core/di/service_locator.dart';

/// Main entry point for the Prod Buddy application.
///
/// Initializes Hive for local storage and launches the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters for custom types
  // Only concrete classes need adapters, not abstract base classes
  Hive.registerAdapter(TaskAdapter());

  // Initialize dependency injection
  await ServiceLocator.instance.initialize();

  runApp(const ProdBuddyApp());
}
