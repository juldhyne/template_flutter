import 'package:get_it/get_it.dart';

import '../network/header_manager.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Register HeaderManager as a singleton
  final headerManager = HeaderManager();
  await headerManager.loadHeaders(); // Load headers asynchronously

  getIt.registerSingleton<HeaderManager>(headerManager);
}
