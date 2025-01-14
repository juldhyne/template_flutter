import '../theme.dart';

class AppRadiusData {
  const AppRadiusData({
    required this.small,
    required this.regular,
    required this.large,
    required this.roundedFull,
  });
  const AppRadiusData.regular()
      : small = const Radius.circular(12),
        regular = const Radius.circular(16),
        large = const Radius.circular(40),
        roundedFull = const Radius.circular(100);

  final Radius small;
  final Radius regular;
  final Radius large;
  final Radius roundedFull;

  AppBorderRadiusData asBorderRadius() => AppBorderRadiusData(this);
}

class AppBorderRadiusData {
  const AppBorderRadiusData(this._radius);

  BorderRadius get small => BorderRadius.all(_radius.small);
  BorderRadius get regular => BorderRadius.all(_radius.regular);
  BorderRadius get large => BorderRadius.all(_radius.large);
  BorderRadius get roundedFull => BorderRadius.all(_radius.roundedFull);

  final AppRadiusData _radius;
}
