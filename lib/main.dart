import 'package:flutter/material.dart';

import 'app.dart';
import 'core/dependencies/dependencies.dart';
import 'core/environments/dev.dart';
import 'core/environments/environment.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.env = DevelopmentEnvironment();

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