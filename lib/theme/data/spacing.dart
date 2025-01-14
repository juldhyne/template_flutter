import '../theme.dart';

class AppSpacingData {
  const AppSpacingData({
    required this.none,
    required this.xxs,
    required this.xs,
    required this.small,
    required this.regular,
    required this.medium,
    required this.large,
    required this.xl,
    required this.xxl,
  });

  factory AppSpacingData.regular() => const AppSpacingData(
        none: 0,
        xxs: 4,
        xs: 8,
        small: 12,
        regular: 16,
        medium: 24,
        large: 32,
        xl: 48,
        xxl: 64,
      );

  final double none;
  final double xxs;
  final double xs;
  final double small;
  final double regular;
  final double medium;
  final double large;
  final double xl;
  final double xxl;

  AppEdgeInsetsSpacingData asInsets() => AppEdgeInsetsSpacingData(this);
}

class AppEdgeInsetsSpacingData {
  const AppEdgeInsetsSpacingData(this._spacing);

  EdgeInsets get none => EdgeInsets.all(_spacing.none);
  EdgeInsets get xxs => EdgeInsets.all(_spacing.xxs);
  EdgeInsets get xs => EdgeInsets.all(_spacing.xs);
  EdgeInsets get small => EdgeInsets.all(_spacing.small);
  EdgeInsets get regular => EdgeInsets.all(_spacing.regular);
  EdgeInsets get medium => EdgeInsets.all(_spacing.medium);
  EdgeInsets get large => EdgeInsets.all(_spacing.large);
  EdgeInsets get xl => EdgeInsets.all(_spacing.xl);
  EdgeInsets get xxl => EdgeInsets.all(_spacing.xxl);

  final AppSpacingData _spacing;
}
