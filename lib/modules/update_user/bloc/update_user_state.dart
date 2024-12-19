part of 'update_user_bloc.dart';

final class UpdateUserState extends Equatable {
  const UpdateUserState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = true,
  });

  final FormzSubmissionStatus status;

  final bool isValid;

  UpdateUserState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status];
}
