import 'package:flutter/foundation.dart';
import 'package:template_flutter/models/app_version_info_model.dart';

import '../../../core/errors/errors.dart';
import '../../../core/helpers/either.dart';
import '../../../core/network/rest_api_service.dart';

class VersionCheckerDatasource {
  VersionCheckerDatasource() {
    _service = RestApiService();
  }

  late RestApiService _service;

  Future<Either<AppError, AppVersionInfo>> getMinimumAppVersion() async {
    try {
      if (kDebugMode) {
        print("[VersionCheckerDatasource]: getMinimumAppVersion");
      }

      // Get authenticated user based on shared preferences token
      final response = await _service.get('app-version/min-version');

      if (response.isSuccess) {
        return Right(AppVersionInfo.fromJson(response.data));
      } else {
        return Left(ServerError(response.message));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      return Left(const UnhandledError("Failed to get minimum app version."));
    }
  }
}
