import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:template_flutter/modules/signup/bloc/signup_bloc.dart';

import '../../../theme/theme.dart';
import '../../authentication/authentication_repository.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupView());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: AppPadding(
        padding: const AppEdgeInsets.all(Spacing.small),
        child: BlocProvider(
          create: (context) => SignupBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isFailure && state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: AppText(state.error!.message)),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            _PasswordInput(),
            _FirstnameInput(),
            _LastnameInput(),
            _LoginButton(),
          ].separateWith(const AppGap.small()),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignupBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('signupForm_emailInput_textField'),
      onChanged: (email) {
        context.read<SignupBloc>().add(SignupEmailChanged(email));
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
      (SignupBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('signupForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<SignupBloc>().add(SignupPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignupBloc bloc) => bloc.state.firstname.displayError,
    );

    return TextField(
      key: const Key('signupForm_firstnameInput_textField'),
      onChanged: (firstname) {
        context.read<SignupBloc>().add(SignupFirstnameChanged(firstname));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'firstname',
        errorText: displayError != null ? 'invalid firstname' : null,
      ),
    );
  }
}

class _LastnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignupBloc bloc) => bloc.state.lastname.displayError,
    );

    return TextField(
      key: const Key('signupForm_lastnameInput_textField'),
      onChanged: (lastname) {
        context.read<SignupBloc>().add(SignupLastnameChanged(lastname));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'lastname',
        errorText: displayError != null ? 'invalid lastname' : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignupBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((SignupBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('signupForm_continue_raisedButton'),
      onPressed: isValid ? () => context.read<SignupBloc>().add(const SignupSubmitted()) : null,
      child: const AppText('Sign up'),
    );
  }
}
