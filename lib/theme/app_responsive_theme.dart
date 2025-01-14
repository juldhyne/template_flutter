import 'dart:ui' as ui;

import 'theme.dart';

enum AppThemeColorMode {
  light,
  dark,
  highContrast,
}

/// Updates automatically the [AppTheme] regarding the current [MediaQuery],
/// as soon as the [theme] isn't overriden.
class AppResponsiveTheme extends StatelessWidget {
  const AppResponsiveTheme({
    Key? key,
    required this.child,
    this.colorMode,
    this.formFactor,
  }) : super(key: key);

  final AppThemeColorMode? colorMode;
  final Widget child;

  final AppFormFactor? formFactor;

  /// Define default color mode based on [MediaQuery.platformBrightnessOf(context)]
  static AppThemeColorMode colorModeOf(BuildContext context) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final useDarkTheme = platformBrightness == ui.Brightness.dark;
    if (useDarkTheme) {
      return AppThemeColorMode.dark;
    }
    final highContrast = MediaQuery.highContrastOf(context);
    if (highContrast) {
      return AppThemeColorMode.highContrast;
    }

    return AppThemeColorMode.light;
  }

  /// Define screen category based on [mediaQuery.size.width]
  static AppFormFactor formFactorOf(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (mediaQuery.size.width < 200) {
      return AppFormFactor.small;
    }

    return AppFormFactor.regular;
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppThemeData.regular();

    /// Updating the colors for the current brightness
    final colorMode = this.colorMode ?? colorModeOf(context);
    switch (colorMode) {
      case AppThemeColorMode.dark:
        theme = theme.withColors(AppColorsData.dark());
        break;
      case AppThemeColorMode.highContrast:
        theme = theme.withColors(AppColorsData.highContrast());
        break;
      case AppThemeColorMode.light:
        break;
    }

    // Updating the sizes for current form factor.
    var formFactor = this.formFactor ?? formFactorOf(context);
    theme = theme.withFormFactor(formFactor);
    if (formFactor == AppFormFactor.small) {
      theme = theme.withTypography(AppTypographyData.small());
    }
    return AppTheme(
      data: theme,
      child: child,
    );
  }
}
