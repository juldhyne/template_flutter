import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:template_flutter/core/errors/errors.dart';

import '../../../models/app_version_info_model.dart';
import '../version_checker_repository.dart';

part 'version_checker_state.dart';

class VersionCheckerCubit extends Cubit<VersionCheckerState> {
  final VersionCheckerRepository _versionCheckerRepository;

  VersionCheckerCubit({required VersionCheckerRepository versionCheckerRepository})
      : _versionCheckerRepository = versionCheckerRepository,
        super(VersionCheckerInitial());

  Future<void> checkAppVersion() async {
    emit(VersionCheckerLoading());
    final result = await _versionCheckerRepository.getMinimumVersion();

    result.fold(
      (error) => emit(VersionCheckerFailure(error: error)),
      (appVersionInfo) async {
        // Get the current app version using `package_info_plus`
        final packageInfo = await PackageInfo.fromPlatform();
        final String currentVersion = packageInfo.version;

        // Compare versions to determine whether the app version is accepted
        if (appVersionInfo.isAfter(AppVersionInfo(minimumVersion: currentVersion))) {
          emit(VersionCheckerDenied());
        } else {
          emit(VersionCheckerAccepted(packageInfo: packageInfo));
        }
      },
    );
  }
}
