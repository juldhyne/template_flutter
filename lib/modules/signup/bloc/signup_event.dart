part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class SignupFirstnameChanged extends SignupEvent {
  const SignupFirstnameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

final class SignupLastnameChanged extends SignupEvent {
  const SignupLastnameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
