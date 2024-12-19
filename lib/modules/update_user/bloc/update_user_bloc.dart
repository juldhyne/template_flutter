import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../authentication/authentication_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

/// A Bloc to manage the update user flow.
/// Handles user updates by interacting with the [AuthenticationRepository].
class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  /// Creates an [UpdateUserBloc] with the required [AuthenticationRepository].
  UpdateUserBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const UpdateUserState()) {
    on<UpdateUserSubmitted>(_onSubmitted);
  }

  /// The repository used for updating the authenticated user.
  final AuthenticationRepository _authenticationRepository;

  /// Handles the submission of the update user form.
  /// If the form is valid, triggers the update via [AuthenticationRepository].
  /// Emits loading, success, or failure states based on the outcome.
  Future<void> _onSubmitted(
    UpdateUserSubmitted event,
    Emitter<UpdateUserState> emit,
  ) async {
    print('[UpdateUserBloc]: _onSubmitted()');
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _authenticationRepository.updateAuthenticatedUser(username: "");

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
