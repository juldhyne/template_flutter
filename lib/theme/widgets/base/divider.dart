import '../../theme.dart';

/// [AppDivider] is the [Divider] widget from Material library that
/// allows you to use paddings defined in the theme

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.padding});

  const AppDivider.xxs({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.xxs);

  const AppDivider.xs({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.xs);

  const AppDivider.small({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.small);

  const AppDivider.regular({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.regular);

  const AppDivider.medium({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.medium);

  const AppDivider.large({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.large);

  const AppDivider.xl({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.xl);

  const AppDivider.xxl({super.key}) : padding = const AppEdgeInsets.symmetric(vertical: Spacing.xxl);

  final AppEdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppPadding(
      padding: padding ?? const AppEdgeInsets.all(Spacing.none),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.colors.divider,
      ),
    );
  }
}
