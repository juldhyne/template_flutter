import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../models/user_model.dart';
import '../authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// A Bloc that manages authentication state by responding to events
/// such as subscription requests or logout actions.
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Constructor for [AuthenticationBloc].
  /// Requires an [AuthenticationRepository] to manage authentication logic.
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.initial()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  /// Repository used to interact with the authentication backend.
  final AuthenticationRepository _authenticationRepository;

  /// Handles the [AuthenticationSubscriptionRequested] event.
  /// Subscribes to the authentication status stream from the repository and
  /// updates the state based on the current status.
  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    if (kDebugMode) {
      print('[AuthenticationBloc]: _onSubscriptionRequested');
    }
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.initial:
            final user = await _tryGetUser();
            return emit(
              user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated(),
            );
          case AuthenticationStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated(),
            );
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
        }
      },
      onError: addError,
    );
  }

  /// Handles the [AuthenticationLogoutPressed] event.
  /// Triggers a logout action in the authentication repository.
  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    if (kDebugMode) {
      print('[AuthenticationBloc]: _onLogoutPressed');
    }
    _authenticationRepository.logOut();
  }

  /// Attempts to retrieve the current authenticated user from the repository.
  /// Returns a [User] if successful, otherwise returns `null`.
  Future<User?> _tryGetUser() async {
    if (kDebugMode) {
      print('[AuthenticationBloc]: _tryGetUser');
    }
    try {
      final user = await _authenticationRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
