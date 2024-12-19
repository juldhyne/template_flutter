import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../update_user/presentation/update_user_view.dart';
import '../bloc/authentication_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UserId(),
            _UpdateUserRedirectionButton(),
            _LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class _UpdateUserRedirectionButton extends StatelessWidget {
  const _UpdateUserRedirectionButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Update user'),
      onPressed: () => navigatorKey.currentState?.pushAndRemoveUntil<void>(
        UpdateUserView.route(),
        (route) => false,
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

class _UserId extends StatelessWidget {
  const _UserId();

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user?.id,
    );

    return Text('UserID: $userId');
  }
}
