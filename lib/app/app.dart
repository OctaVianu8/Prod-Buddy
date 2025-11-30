import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';

/// Main application widget.
///
/// Sets up the MaterialApp with theme, routes, and global configuration.
/// This is the root widget that gets initialized in main.dart.
class ProdBuddyApp extends StatelessWidget {
  const ProdBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prod Buddy',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // TODO: Make this user-configurable
      // Routing
      initialRoute: AppRoutes.taskList,
      onGenerateRoute: AppRoutes.generateRoute,

      // TODO: Add global providers when state management is implemented
      // TODO: Add localization support
      // TODO: Add error handling and logging
    );
  }
}
