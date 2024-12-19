part of 'update_user_bloc.dart';

final class UpdateUserState extends Equatable {
  const UpdateUserState({
    this.status = FormzSubmissionStatus.initial,
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.isValid = true,
  });

  final FormzSubmissionStatus status;
  final Firstname firstname;
  final Lastname lastname;
  final bool isValid;

  UpdateUserState copyWith({
    FormzSubmissionStatus? status,
    Firstname? firstname,
    Lastname? lastname,
    bool? isValid,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, firstname, lastname];
}
