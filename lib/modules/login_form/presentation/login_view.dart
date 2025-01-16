import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme.dart';
import '../../authentication/authentication_repository.dart';
import '../../version_checker/cubit/version_checker_cubit.dart';
import '../bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: AppPadding(
        padding: const AppEdgeInsets.all(Spacing.small),
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure && state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: AppText(state.error!.message)),
            );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EmailInput(),
                _PasswordInput(),
                _LoginButton(),
                _SignupRedirectionButton(),
              ].separateWith(const AppGap.small()),
            ),
          ),
          if (context.read<VersionCheckerCubit>().state is VersionCheckerAccepted)
            AppText(
                "Version ${(context.read<VersionCheckerCubit>().state as VersionCheckerAccepted).packageInfo.version}")
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      decoration: InputDecoration(
        labelText: 'email',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid ? () => context.read<LoginBloc>().add(const LoginSubmitted()) : null,
      child: const AppText('Login'),
    );
  }
}

class _SignupRedirectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.push('/signup'),
      child: const AppText('Sign up'),
    );
  }
}
