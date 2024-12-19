import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../core/errors/errors.dart';
import '../../../models/firstname_field_model.dart';
import '../../../models/lastname_field_model.dart';
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
    on<UpdateUserFirstnameChanged>(_onFirstnameChanged);
    on<UpdateUserLastnameChanged>(_onLastnameChanged);
    on<UpdateUserSubmitted>(_onSubmitted);
  }

  /// The repository used for updating the authenticated user.
  final AuthenticationRepository _authenticationRepository;

  /// Handles changes to the firstname field.
  /// Validates the new firstname and updates the state.
  void _onFirstnameChanged(
    UpdateUserFirstnameChanged event,
    Emitter<UpdateUserState> emit,
  ) {
    print('[UpdateUserBloc]: _onFirstnameChanged');
    final firstname = Firstname.dirty(event.firstname);
    emit(
      state.copyWith(
        firstname: firstname,
        isValid: Formz.validate([firstname, state.lastname]),
      ),
    );
  }

  /// Handles changes to the lastname field.
  /// Validates the new lastname and updates the state.
  void _onLastnameChanged(
    UpdateUserLastnameChanged event,
    Emitter<UpdateUserState> emit,
  ) {
    print('[UpdateUserBloc]: _onLastnameChanged');
    final lastname = Lastname.dirty(event.lastname);
    emit(
      state.copyWith(
        lastname: lastname,
        isValid: Formz.validate([state.lastname, lastname]),
      ),
    );
  }

  /// Handles the submission of the update user form.
  /// If the form is valid, triggers the update via [AuthenticationRepository].
  /// Emits loading, success, or failure states based on the outcome.
  Future<void> _onSubmitted(
    UpdateUserSubmitted event,
    Emitter<UpdateUserState> emit,
  ) async {
    print('[UpdateUserBloc]: _onSubmitted');
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authenticationRepository.updateAuthenticatedUser(
        firstname: state.firstname.value,
        lastname: state.lastname.value,
      );

      result.fold(
        (error) => emit(state.copyWith(status: FormzSubmissionStatus.failure, error: error)),
        (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }
}
