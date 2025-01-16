import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../core/errors/errors.dart';
import '../../../models/email_field_model.dart';
import '../../../models/password_field_model.dart';
import '../../authentication/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

/// A Bloc that manages the login flow, including email and password changes,
/// and submission of the login form.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Creates a [LoginBloc] with the required [AuthenticationRepository].
  /// Handles the login logic and updates the state accordingly.
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  /// The repository used for authentication actions such as login.
  final AuthenticationRepository _authenticationRepository;

  /// Handles changes to the Email field.
  /// Validates the new Email and updates the state.
  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    print('[LoginBloc]: _onEmailChanged');
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  /// Handles changes to the password field.
  /// Validates the new password and updates the state.
  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    print('[LoginBloc]: _onPasswordChanged');
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  /// Handles the submission of the login form.
  /// If the form is valid, attempts to log in via the [AuthenticationRepository].
  /// Emits loading, success, or failure states based on the outcome.
  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print('[LoginBloc]: _onSubmitted');
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authenticationRepository.login(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (error) => emit(state.copyWith(status: FormzSubmissionStatus.failure, error: error)),
        (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }
}
