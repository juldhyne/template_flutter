import 'package:flutter/material.dart';

import 'app.dart';
import 'core/dependencies/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependencies
  await setupDependencies();

  runApp(const MainApp());
}



/**
 * TODO:
 * Forms
 * Infinite Lists
 * Redirection/Router
 * Notifications
 * Backend calls
 * Errors
 * Versions
 * Authentication
 * Dark mode
 * Snackbars
 * Images
 * Searches
 */


/**
 * Forms 
 * Handle multi steps and multi steps validations
 * local errors (min length, etc)
 * server errors (email already used, etc)
 */