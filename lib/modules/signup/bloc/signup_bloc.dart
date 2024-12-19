import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../models/email_field_model.dart';
import '../../../models/firstname_field_model.dart';
import '../../../models/lastname_field_model.dart';
import '../../../models/password_field_model.dart';
import '../../authentication/authentication_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

/// A Bloc that manages the signup flow, including email and password changes,
/// and submission of the signup form.
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  /// Creates a [SignupBloc] with the required [AuthenticationRepository].
  /// Handles the signup logic and updates the state accordingly.
  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupFirstnameChanged>(_onFirstnameChanged);
    on<SignupLastnameChanged>(_onLastnameChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  /// The repository used for authentication actions such as signup.
  final AuthenticationRepository _authenticationRepository;

  /// Handles changes to the Email field.
  /// Validates the new Email and updates the state.
  void _onEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    print('[SignupBloc]: _onEmailChanged()');
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password, state.firstname, state.lastname]),
      ),
    );
  }

  /// Handles changes to the password field.
  /// Validates the new password and updates the state.
  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    print('[SignupBloc]: _onPasswordChanged()');
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password, state.firstname, state.lastname]),
      ),
    );
  }

  /// Handles changes to the firstname field.
  /// Validates the new firstname and updates the state.
  void _onFirstnameChanged(
    SignupFirstnameChanged event,
    Emitter<SignupState> emit,
  ) {
    print('[SignupBloc]: _onFirstnameChanged()');
    final firstname = Firstname.dirty(event.firstname);
    emit(
      state.copyWith(
        firstname: firstname,
        isValid: Formz.validate([state.email, state.password, firstname, state.lastname]),
      ),
    );
  }

  /// Handles changes to the lastname field.
  /// Validates the new lastname and updates the state.
  void _onLastnameChanged(
    SignupLastnameChanged event,
    Emitter<SignupState> emit,
  ) {
    print('[SignupBloc]: _onLastnameChanged()');
    final lastname = Lastname.dirty(event.lastname);
    emit(
      state.copyWith(
        lastname: lastname,
        isValid: Formz.validate([state.email, state.password, state.lastname, lastname]),
      ),
    );
  }

  /// Handles the submission of the signup form.
  /// If the form is valid, attempts to log in via the [AuthenticationRepository].
  /// Emits loading, success, or failure states based on the outcome.
  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    print('[SignupBloc]: _onSubmitted()');
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signup(
          email: state.email.value,
          password: state.password.value,
          firstname: state.firstname.value,
          lastname: state.lastname.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
