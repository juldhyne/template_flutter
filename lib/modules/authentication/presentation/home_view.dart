import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme.dart';
import '../bloc/authentication_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _UserId(),
            const _UpdateUserRedirectionButton(),
            const _LogoutButton(),
          ].separateWith(const AppGap.small()),
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
      child: const AppText('Update user'),
      onPressed: () => context.push('/update_user'),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const AppText('Logout'),
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

    return AppText('UserID: $userId');
  }
}
