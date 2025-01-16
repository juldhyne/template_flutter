import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:template_flutter/modules/update_user_form/bloc/update_user_bloc.dart';

import '../../../theme/theme.dart';
import '../../authentication/authentication_repository.dart';

class UpdateUserView extends StatelessWidget {
  const UpdateUserView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateUserView());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: AppPadding(
        padding: const AppEdgeInsets.all(Spacing.small),
        child: BlocProvider(
          create: (context) => UpdateUserBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const UpdateUserForm(),
        ),
      ),
    );
  }
}

class UpdateUserForm extends StatelessWidget {
  const UpdateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserBloc, UpdateUserState>(
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
            _FirstnameInput(),
            _LastnameInput(),
            _LoginButton(),
          ].separateWith(const AppGap.small()),
        ),
      ),
    );
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (UpdateUserBloc bloc) => bloc.state.firstname.displayError,
    );

    return TextField(
      key: const Key('updateUserForm_firstnameInput_textField'),
      onChanged: (firstname) {
        context.read<UpdateUserBloc>().add(UpdateUserFirstnameChanged(firstname));
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
      (UpdateUserBloc bloc) => bloc.state.lastname.displayError,
    );

    return TextField(
      key: const Key('updateUserForm_lastnameInput_textField'),
      onChanged: (lastname) {
        context.read<UpdateUserBloc>().add(UpdateUserLastnameChanged(lastname));
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
      (UpdateUserBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((UpdateUserBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('updateUserForm_continue_raisedButton'),
      onPressed: isValid ? () => context.read<UpdateUserBloc>().add(const UpdateUserSubmitted()) : null,
      child: const AppText('Update'),
    );
  }
}
