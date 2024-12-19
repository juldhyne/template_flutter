import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';
import 'datasources/authentication_datasource.dart';
import 'datasources/shared_preferences_datasource.dart';

/// Represents the authentication status of the user.
enum AuthenticationStatus {
  initial, // The initial status before any authentication check.
  unauthenticated, // The user is not authenticated.
  authenticated // The user is authenticated.
}

/// A repository that handles user authentication logic and manages
/// the authentication status of the application.
class AuthenticationRepository {
  // Datasources
  final AuthenticationDatasource authenticationDatasource;
  final SharedPreferencesDatasource sharedPreferencesDatasource;

  AuthenticationRepository({
    required this.authenticationDatasource,
    required this.sharedPreferencesDatasource,
  });

  /// Stream controller to broadcast authentication status changes.
  final _controller = StreamController<AuthenticationStatus>();

  /// The currently authenticated user, if any.
  User? _user;

  /// A stream that provides the current authentication status.
  /// It first yields the initial status and then listens to status changes.
  Stream<AuthenticationStatus> get status async* {
    if (kDebugMode) {
      print('[AuthenticationRepository]: status stream accessed');
    }
    yield AuthenticationStatus.initial;
    yield* _controller.stream;
  }

  /// Retrieves the currently authenticated user based on the stored token.
  /// - Returns the [User] if a token is stored and the user is already loaded or fetched.
  /// - Returns `null` if no token is found.
  Future<User?> getUser() async {
    if (kDebugMode) {
      print('[AuthenticationRepository]: getUser()');
    }

    final token = await sharedPreferencesDatasource.getSessionToken();
    if (token == null) return null;

    // If the user is already loaded, return the cached user.
    if (_user != null) return _user;

    // Retrieve user from the datasource.
    final result = await authenticationDatasource.getAuthenticatedUser();

    return result.fold(
      (error) => null,
      (user) => user,
    );
  }

  /// Logs in the user with the provided credentials and saves a session token.
  /// - Updates the authentication status to `authenticated`.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (kDebugMode) {
      print('[AuthenticationRepository]: logIn()');
    }

    final result = await authenticationDatasource.login(
      email: email,
      password: password,
    );

    result.fold(
      (error) => null,
      (authResponse) async {
        if (authResponse.token != null) {
          await sharedPreferencesDatasource.setSessionToken(token: authResponse.token!);

          _controller.add(AuthenticationStatus.authenticated);
        }
      },
    );
  }

  /// Create the user with the provided credentials and saves a session token.
  /// - Updates the authentication status to `authenticated`.
  Future<void> signup({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    if (kDebugMode) {
      print('[AuthenticationRepository]: signup()');
    }

    final result = await authenticationDatasource.signup(
      email: email,
      password: password,
      firstname: firstname,
      lastname: lastname,
    );

    result.fold(
      (error) => null,
      (authResponse) async {
        if (authResponse.token != null) {
          await sharedPreferencesDatasource.setSessionToken(token: authResponse.token!);

          _controller.add(AuthenticationStatus.authenticated);
        }
      },
    );
  }

  /// Updates the authenticated user's information.
  /// - Simulates an API call to fetch updated user details.
  /// - Updates the authentication status to `authenticated`.
  Future<void> updateAuthenticatedUser({
    required String firstname,
    required String lastname,
  }) async {
    print('[AuthenticationRepository]: updateAuthenticatedUser()');

    // Simulate a user update.
    final result = await authenticationDatasource.updateUser(firstname: firstname, lastname: lastname);
    result.fold(
      (error) => null,
      (updatedUser) {
        _user = updatedUser;
        // This triggers the authentication bloc listener and will refresh authentication state user
        _controller.add(AuthenticationStatus.authenticated);
      },
    );
  }

  /// Logs out the user by clearing the stored session token and updating the status.
  /// - Updates the authentication status to `unauthenticated`.
  Future<void> logOut() async {
    print('[AuthenticationRepository]: logOut()');

    // Clear the shared preferences token.
    await sharedPreferencesDatasource.clearSessionToken();

    // Notify listeners of unauthenticated status.
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  /// Disposes the stream controller to free up resources.
  void dispose() {
    print('[AuthenticationRepository]: dispose()');
    _controller.close();
  }
}
