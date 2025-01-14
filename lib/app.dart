import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';
import 'modules/authentication/authentication_repository.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'modules/authentication/datasources/authentication_datasource.dart';
import 'modules/authentication/datasources/shared_preferences_datasource.dart';
import 'modules/authentication/presentation/home_view.dart';
import 'modules/authentication/presentation/splash_screen.dart';
import 'modules/login/presentation/login_view.dart';
import 'modules/version_checker/cubit/version_checker_cubit.dart';
import 'modules/version_checker/datasources/version_checker_datasource.dart';
import 'modules/version_checker/version_checker_repository.dart';
import 'theme/theme.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final VersionCheckerRepository _versionCheckerRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository(
      authenticationDatasource: AuthenticationDatasource(),
      sharedPreferencesDatasource: SharedPreferencesDatasource(),
    );
    _versionCheckerRepository = VersionCheckerRepository(
      versionCheckerDatasource: VersionCheckerDatasource(),
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => VersionCheckerCubit(
              versionCheckerRepository: _versionCheckerRepository,
            )..checkAppVersion(), // Initialize validation
          ),
        ],
        child: AppResponsiveTheme(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            builder: (context, child) {
              return BlocListener<VersionCheckerCubit, VersionCheckerState>(
                listener: (context, state) {
                  if (state is VersionCheckerAccepted) {
                    context.read<AuthenticationBloc>().add(AuthenticationSubscriptionRequested());
                  }
                  if (state is VersionCheckerDenied) {
                    // Show the modal dialog if validation fails
                    showDialog(
                      context: navigatorKey.currentState!.overlay!.context,
                      barrierDismissible: false, // Prevent dismissing by tapping outside
                      builder: (_) => const AlertDialog(
                        title: AppText('App deprecated'),
                        content:
                            AppText('Your app is deprecated and requires latest updates to be used. Please update it.'),
                        actions: [], // No actions to prevent dismissal
                      ),
                    );
                  }
                  if (state is VersionCheckerFailure) {
                    // Show the modal dialog if validation fails
                    showDialog(
                      context: navigatorKey.currentState!.overlay!.context,
                      barrierDismissible: false, // Prevent dismissing by tapping outside
                      builder: (_) => AlertDialog(
                        title: const AppText('Error message'),
                        content: AppText(state.error.message),
                        actions: [
                          TextButton(
                            child: const AppText('Refresh'),
                            onPressed: () => context.read<VersionCheckerCubit>().checkAppVersion(),
                          )
                        ], // No actions to prevent dismissal
                      ),
                    );
                  }
                  if (state is VersionCheckerLoading) {
                    // Ensure the dialog is dismissed when refreshing starts
                    if (Navigator.canPop(navigatorKey.currentState!.context)) {
                      Navigator.pop(navigatorKey.currentState!.context);
                    }
                  }
                },
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  // Avoid redirection when overriding authenticated user on user update
                  listenWhen: (previous, current) => previous.status != current.status,
                  listener: (context, state) {
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                        navigatorKey.currentState?.pushAndRemoveUntil<void>(
                          HomeView.route(),
                          (route) => false,
                        );
                      case AuthenticationStatus.unauthenticated:
                        navigatorKey.currentState?.pushAndRemoveUntil<void>(
                          LoginView.route(),
                          (route) => false,
                        );
                      case AuthenticationStatus.initial:
                        break;
                    }
                  },
                  child: child,
                ),
              );
            },
            onGenerateRoute: (_) => SplashScreen.route(),
          ),
        ),
      ),
    );
  }
}
