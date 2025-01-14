import 'package:flutter/material.dart';

import 'data/data.dart';

export 'data/colors.dart';
export 'data/data.dart';
export 'data/durations.dart';
export 'data/form_factor.dart';
export 'data/radius.dart';
export 'data/spacing.dart';
export 'data/typography.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}
