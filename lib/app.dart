import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';
import 'modules/authentication/authentication_repository.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'modules/authentication/datasources/authentication_datasource.dart';
import 'modules/authentication/datasources/shared_preferences_datasource.dart';
import 'modules/authentication/presentation/home_view.dart';
import 'modules/authentication/presentation/splash_screen.dart';
import 'modules/login/presentation/login_view.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository(
      authenticationDatasource: AuthenticationDatasource(),
      sharedPreferencesDatasource: SharedPreferencesDatasource(),
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
      child: BlocProvider(
        lazy: false,
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        )..add(AuthenticationSubscriptionRequested()),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
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
            );
          },
          onGenerateRoute: (_) => SplashScreen.route(),
        ),
      ),
    );
  }
}
