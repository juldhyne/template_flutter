import '../../core/errors/errors.dart';
import '../../core/helpers/either.dart';
import '../../models/app_version_info_model.dart';
import 'datasources/version_checker_datasource.dart';

class VersionCheckerRepository {
  final VersionCheckerDatasource versionCheckerDatasource;

  VersionCheckerRepository({
    required this.versionCheckerDatasource,
  });

  Future<Either<AppError, AppVersionInfo>> getMinimumVersion() async {
    // TODO: If endpoint setup remove this
    return Right(AppVersionInfo(
      minimumVersion: '0.0.0',
    ));

    // final result = await versionCheckerDatasource.getMinimumAppVersion();
    // return result;
  }
}
