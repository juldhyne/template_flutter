import 'package:gap/gap.dart';

import '../../theme.dart';

enum Spacing {
  none,
  xxs,
  xs,
  small,
  regular,
  medium,
  large,
  xl,
  xxl,
}

extension SpacingExtension on Spacing {
  double getSpacing(AppThemeData theme) {
    switch (this) {
      case Spacing.none:
        return theme.spacing.none;
      case Spacing.xxs:
        return theme.spacing.xxs;
      case Spacing.xs:
        return theme.spacing.xs;
      case Spacing.small:
        return theme.spacing.small;
      case Spacing.regular:
        return theme.spacing.regular;
      case Spacing.medium:
        return theme.spacing.medium;
      case Spacing.large:
        return theme.spacing.large;
      case Spacing.xl:
        return theme.spacing.xl;
      case Spacing.xxl:
        return theme.spacing.xxl;
    }
  }
}

/// [AppGap] is the [Gap] widget from the gap library that
/// allows you to use values predefined in the theme
///
/// `xxs`: **4**
///
/// `xs`: **8**
///
/// `small`: **12**
///
/// `regular`: **16**
///
/// `medium`: **24**
///
/// `large`: **32**
///
/// `xl`: **48**
///
/// `xxl`: **64**
class AppGap extends StatelessWidget {
  const AppGap(
    this.size, {
    super.key,
  });

  /// `xxs`: **4**
  const AppGap.xxs({
    super.key,
  }) : size = Spacing.xxs;

  /// `xs`: **8**
  const AppGap.xs({
    super.key,
  }) : size = Spacing.xs;

  /// `small`: **12**
  const AppGap.small({
    super.key,
  }) : size = Spacing.small;

  /// `regular`: **16**
  const AppGap.regular({
    super.key,
  }) : size = Spacing.regular;

  /// `medium`: **24**
  const AppGap.medium({
    super.key,
  }) : size = Spacing.medium;

  /// `large`: **32**
  const AppGap.large({
    super.key,
  }) : size = Spacing.large;

  /// `xl`: **48**
  const AppGap.xl({
    super.key,
  }) : size = Spacing.xl;

  /// `xxl`: **64**
  const AppGap.xxl({
    super.key,
  }) : size = Spacing.xxl;

  final Spacing size;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Gap(size.getSpacing(theme));
  }
}
