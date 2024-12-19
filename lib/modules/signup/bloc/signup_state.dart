part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final Firstname firstname;
  final Lastname lastname;
  final bool isValid;

  SignupState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    Firstname? firstname,
    Lastname? lastname,
    bool? isValid,
  }) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, email, password, firstname, lastname];
}
