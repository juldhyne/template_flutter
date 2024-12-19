part of 'update_user_bloc.dart';

sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUserSubmitted extends UpdateUserEvent {
  const UpdateUserSubmitted();
}
