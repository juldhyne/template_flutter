import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/modules/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:template_flutter/modules/version_checker/presentation/version_checker_dialogs_service.dart';

import 'modules/authentication/authentication_repository.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'modules/authentication/datasources/authentication_datasource.dart';
import 'modules/authentication/datasources/shared_preferences_datasource.dart';
import 'modules/authentication/presentation/home_view.dart';
import 'modules/authentication/presentation/splash_screen.dart';
import 'modules/login_form/presentation/login_view.dart';
import 'modules/signup_form/presentation/signup_view.dart';
import 'modules/update_user_form/presentation/update_user_view.dart';
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
          child: MaterialApp.router(
            routerConfig: _router,
            // Version Checker will look if app is not deprecated
            builder: (context, child) {
              return BlocListener<VersionCheckerCubit, VersionCheckerState>(
                listener: (context, state) {
                  if (state is VersionCheckerAccepted) {
                    context.read<AuthenticationBloc>().add(AuthenticationSubscriptionRequested());
                  }
                  if (state is VersionCheckerDenied) {
                    // Show the modal dialog if validation fails
                    const VersionCheckerDialogsService().showVersionCheckerDeniedDialog(context);
                  }
                  if (state is VersionCheckerFailure) {
                    // Show the modal dialog if validation fails
                    const VersionCheckerDialogsService().showVersionCheckerFailedDialog(
                      context,
                      errorMessage: state.error.message,
                      refresh: () => context.read<VersionCheckerCubit>().checkAppVersion(),
                    );
                  }
                  if (state is VersionCheckerLoading) {
                    // Ensure the dialog is dismissed when refreshing starts
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  // Avoid redirection when overriding authenticated user on user update
                  listenWhen: (previous, current) => previous.status != current.status,
                  listener: (c, state) {
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                        _router.go('/home');
                      case AuthenticationStatus.unauthenticated:
                        _router.go('/login');
                      case AuthenticationStatus.initial:
                        break;
                    }
                  },
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'splash_screen',
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(
          body: child,
          bottomNavigationBar: const BottomNavigationBarWidget(),
        );
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          name: 'update_user',
          path: '/update_user',
          builder: (context, state) => const UpdateUserView(),
        ),
      ],
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignupView(),
    ),
  ],
);
