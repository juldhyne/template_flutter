import '../../../theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: AppText('...'),
      ),
    );
  }
}
