part of 'version_checker_cubit.dart';

sealed class VersionCheckerState extends Equatable {
  const VersionCheckerState();

  @override
  List<Object> get props => [];
}

final class VersionCheckerInitial extends VersionCheckerState {}

final class VersionCheckerLoading extends VersionCheckerState {}

final class VersionCheckerAccepted extends VersionCheckerState {
  final PackageInfo packageInfo;

  const VersionCheckerAccepted({required this.packageInfo});

  @override
  List<Object> get props => [packageInfo];
}

final class VersionCheckerDenied extends VersionCheckerState {}

final class VersionCheckerFailure extends VersionCheckerState {
  final AppError error;

  const VersionCheckerFailure({required this.error});

  @override
  List<Object> get props => [error];
}
