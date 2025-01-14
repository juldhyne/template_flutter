import 'package:flutter/foundation.dart';

import '../theme.dart';

class AppThemeData {
  const AppThemeData({
    required this.colors,
    required this.durations,
    required this.formFactor,
    required this.radius,
    required this.spacing,
    required this.typography,
    TargetPlatform? platform,
  }) : _platform = platform;

  // Default theme provided
  factory AppThemeData.regular() => AppThemeData(
        colors: AppColorsData.light(),
        durations: AppDurationsData.regular(),
        formFactor: AppFormFactor.regular,
        radius: const AppRadiusData.regular(),
        spacing: AppSpacingData.regular(),
        typography: AppTypographyData.regular(),
      );

  final AppColorsData colors;
  final AppDurationsData durations;
  final AppFormFactor formFactor;
  final AppRadiusData radius;
  final AppSpacingData spacing;
  final AppTypographyData typography;

  // ignore: unused_field
  final TargetPlatform? _platform;
  TargetPlatform get platform => defaultTargetPlatform;

  /// Override current theme with [colors]
  AppThemeData withColors(AppColorsData colors) {
    return AppThemeData(
      colors: colors,
      durations: durations,
      formFactor: formFactor,
      radius: radius,
      spacing: spacing,
      typography: typography,
      platform: platform,
    );
  }

  /// Override current theme with [typography]
  AppThemeData withTypography(AppTypographyData typography) {
    return AppThemeData(
      colors: colors,
      durations: durations,
      formFactor: formFactor,
      radius: radius,
      spacing: spacing,
      typography: typography,
      platform: platform,
    );
  }

  /// Override current theme with [formFactor]
  AppThemeData withFormFactor(AppFormFactor formFactor) {
    return AppThemeData(
      colors: colors,
      durations: durations,
      formFactor: formFactor,
      radius: radius,
      spacing: spacing,
      typography: typography,
      platform: platform,
    );
  }
}
