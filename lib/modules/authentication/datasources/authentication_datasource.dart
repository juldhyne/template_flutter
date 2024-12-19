import 'package:flutter/foundation.dart';

import '../../../core/errors/errors.dart';
import '../../../core/helpers/either.dart';
import '../../../core/network/rest_api_service.dart';
import '../../../models/auth_response_model.dart';
import '../../../models/user_model.dart';

class AuthenticationDatasource {
  AuthenticationDatasource() {
    _service = RestApiService();
  }

  late RestApiService _service;

  Future<Either<AppError, User>> getAuthenticatedUser() async {
    try {
      if (kDebugMode) {
        print("[UserDatasource]: getAuthenticatedUser");
      }

      // Get authenticated user based on shared preferences token
      final response = await _service.get('auth/user');

      if (response.isSuccess) {
        return Right(User.fromJson(response.data));
      } else {
        return Left(ServerError(response.message));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return Left(const UnhandledError("Failed to get authenticated user."));
    }
  }

  Future<Either<AppError, AuthResponse>> login({required String email, required String password}) async {
    try {
      if (kDebugMode) {
        print("[AuthenticationDatasource]: login");
      }

      // Get authenticated user based on shared preferences token
      final response = await _service.post('auth/login', body: {
        "username": email,
        "password": password,
      });

      if (response.isSuccess) {
        return Right(AuthResponse.fromJson(response.data));
      } else {
        return Left(ServerError(response.message));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return Left(const UnhandledError("Failed to sign in."));
    }
  }

  Future<Either<AppError, AuthResponse>> signup({required String email, required String password}) async {
    try {
      if (kDebugMode) {
        print("[AuthenticationDatasource]: signup");
      }

      // Get authenticated user based on shared preferences token
      final response = await _service.post('auth/signup', body: {
        "username": email,
        "password": password,
      });

      if (response.isSuccess) {
        return Right(AuthResponse.fromJson(response.data));
      } else {
        return Left(ServerError(response.message));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return Left(const UnhandledError("Failed to sign in."));
    }
  }

  Future<Either<AppError, User>> updateUser({required String email}) async {
    try {
      if (kDebugMode) {
        print("[AuthenticationDatasource]: login");
      }

      // Get authenticated user based on shared preferences token
      final response = await _service.post('auth/login', body: {
        "username": email,
      });

      if (response.isSuccess) {
        return Right(User.fromJson(response.data));
      } else {
        return Left(ServerError(response.message));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return Left(const UnhandledError("Failed to sign in."));
    }
  }
}
