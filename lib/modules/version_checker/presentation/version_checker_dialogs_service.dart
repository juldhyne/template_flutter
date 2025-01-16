import 'package:template_flutter/theme/theme.dart';

class VersionCheckerDialogsService {
  const VersionCheckerDialogsService();

  void showVersionCheckerDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (_) => const AlertDialog(
        title: AppText('App deprecated'),
        content: AppText('Your app is deprecated and requires latest updates to be used. Please update it.'),
        actions: [], // No actions to prevent dismissal
      ),
    );
  }

  void showVersionCheckerFailedDialog(BuildContext context, {required String errorMessage, required Function refresh}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (_) => AlertDialog(
        title: const AppText('Error message'),
        content: AppText(errorMessage),
        actions: [
          TextButton(
            child: const AppText('Refresh'),
            onPressed: () => refresh(),
          )
        ],
      ),
    );
  }
}
