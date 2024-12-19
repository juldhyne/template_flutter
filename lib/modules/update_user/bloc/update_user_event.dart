part of 'update_user_bloc.dart';

sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserFirstnameChanged extends UpdateUserEvent {
  const UpdateUserFirstnameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

final class UpdateUserLastnameChanged extends UpdateUserEvent {
  const UpdateUserLastnameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

final class UpdateUserSubmitted extends UpdateUserEvent {
  const UpdateUserSubmitted();
}
