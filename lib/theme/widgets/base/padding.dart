import '../../theme.dart';

class AppEdgeInsets {
  const AppEdgeInsets.all(Spacing value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const AppEdgeInsets.symmetric({
    Spacing vertical = Spacing.none,
    Spacing horizontal = Spacing.none,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  const AppEdgeInsets.only({
    this.left = Spacing.none,
    this.top = Spacing.none,
    this.right = Spacing.none,
    this.bottom = Spacing.none,
  });

  const AppEdgeInsets.xxs()
      : left = Spacing.xxs,
        top = Spacing.xxs,
        right = Spacing.xxs,
        bottom = Spacing.xxs;

  const AppEdgeInsets.xs()
      : left = Spacing.xs,
        top = Spacing.xs,
        right = Spacing.xs,
        bottom = Spacing.xs;

  const AppEdgeInsets.small()
      : left = Spacing.small,
        top = Spacing.small,
        right = Spacing.small,
        bottom = Spacing.small;

  const AppEdgeInsets.regular()
      : left = Spacing.regular,
        top = Spacing.regular,
        right = Spacing.regular,
        bottom = Spacing.regular;

  const AppEdgeInsets.medium()
      : left = Spacing.medium,
        top = Spacing.medium,
        right = Spacing.medium,
        bottom = Spacing.medium;

  const AppEdgeInsets.large()
      : left = Spacing.large,
        top = Spacing.large,
        right = Spacing.large,
        bottom = Spacing.large;

  const AppEdgeInsets.xl()
      : left = Spacing.xl,
        top = Spacing.xl,
        right = Spacing.xl,
        bottom = Spacing.xl;

  const AppEdgeInsets.xxl()
      : left = Spacing.xxl,
        top = Spacing.xxl,
        right = Spacing.xxl,
        bottom = Spacing.xxl;

  final Spacing left;
  final Spacing top;
  final Spacing right;
  final Spacing bottom;

  EdgeInsets toEdgeInsets(AppThemeData theme) {
    return EdgeInsets.only(
      left: left.getSpacing(theme),
      top: top.getSpacing(theme),
      right: right.getSpacing(theme),
      bottom: bottom.getSpacing(theme),
    );
  }
}

/// Define padding to each side of the @child.
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

class AppPadding extends StatelessWidget {
  const AppPadding({
    super.key,
    this.padding = const AppEdgeInsets.all(Spacing.none),
    this.child,
  });

  /// Define padding to each side of the @child.
  ///
  /// `xxs`: **4**
  const AppPadding.xxs({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.xxs);

  /// Define padding to each side of the @child.
  ///
  /// `xs`: **8**
  const AppPadding.xs({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.xs);

  /// Define padding to each side of the @child.
  ///
  /// `small`: **12**
  const AppPadding.small({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.small);

  /// Define padding to each side of the @child.
  ///
  /// `regular`: **16**
  const AppPadding.regular({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.regular);

  /// Define padding to each side of the @child.
  ///
  /// `medium`: **24**
  const AppPadding.medium({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.medium);

  /// Define padding to each side of the @child.
  ///
  /// `large`: **32**
  const AppPadding.large({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.large);

  /// Define padding to each side of the @child.
  ///
  /// `xl`: **48**
  const AppPadding.xl({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.xl);

  /// Define padding to each side of the @child.
  ///
  /// `xxl`: **64**
  const AppPadding.xxl({
    super.key,
    this.child,
  }) : padding = const AppEdgeInsets.all(Spacing.xxl);

  final AppEdgeInsets padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: padding.toEdgeInsets(theme),
      child: child,
    );
  }
}
