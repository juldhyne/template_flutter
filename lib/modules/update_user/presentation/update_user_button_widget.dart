import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../authentication/authentication_repository.dart';
import '../bloc/update_user_bloc.dart';

class UpdateUserButtonWidget extends StatelessWidget {
  const UpdateUserButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const _Button(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (UpdateUserBloc bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((UpdateUserBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('updateUserForm_continue_raisedButton'),
      onPressed: isValid ? () => context.read<UpdateUserBloc>().add(const UpdateUserSubmitted()) : null,
      child: const Text('Update'),
    );
  }
}
