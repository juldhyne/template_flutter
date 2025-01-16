part of 'update_user_bloc.dart';

final class UpdateUserState extends Equatable {
  const UpdateUserState({
    this.status = FormzSubmissionStatus.initial,
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.isValid = true,
    this.error,
  });

  final FormzSubmissionStatus status;
  final Firstname firstname;
  final Lastname lastname;
  final bool isValid;
  final AppError? error;

  UpdateUserState copyWith({
    FormzSubmissionStatus? status,
    Firstname? firstname,
    Lastname? lastname,
    bool? isValid,
    AppError? error,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      isValid: isValid ?? this.isValid,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstname,
        lastname,
        error,
      ];
}
