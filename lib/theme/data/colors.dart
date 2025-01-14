import '../theme.dart';

class AppColorsData {
  const AppColorsData({
    required this.primary,
    required this.secondary,
    required this.backgroundColor,
    required this.text,
    required this.circularProgressIndicator,
    required this.divider,
    required this.endOfListIndicator,
    required this.imagePlaceholder,
  });

  factory AppColorsData.light() => const AppColorsData(
        primary: Color(0XFF1B3C91),
        secondary: Color(0XFFD9E4FF),
        backgroundColor: Color(0XFFFFFFFF),
        text: Color(0XFF231E23),
        circularProgressIndicator: Color(0XFF1B3C91),
        divider: Color(0XFFE5E7EB),
        endOfListIndicator: Color(0XFFE5E7EB),
        imagePlaceholder: Color(0XFFE5E7EB),
      );

  factory AppColorsData.dark() => const AppColorsData(
        primary: Color(0XFF1B3C91),
        secondary: Color(0XFFD9E4FF),
        backgroundColor: Color(0XFF231E23),
        text: Color(0XFFFFFFFF),
        circularProgressIndicator: Color(0XFF1B3C91),
        divider: Color(0xFF374151),
        endOfListIndicator: Color(0XFFE5E7EB),
        imagePlaceholder: Color(0XFFE5E7EB),
      );

  factory AppColorsData.highContrast() => const AppColorsData(
        primary: Color(0XFF1B3C91),
        secondary: Color(0XFFD9E4FF),
        backgroundColor: Color(0XFFFFFFFF),
        text: Color(0XFF231E23),
        circularProgressIndicator: Color(0XFF1B3C91),
        divider: Color(0XFFE5E7EB),
        endOfListIndicator: Color(0XFFE5E7EB),
        imagePlaceholder: Color(0XFFE5E7EB),
      );

  // Primary
  final Color primary;

  // Secondary
  final Color secondary;

  // Background
  final Color backgroundColor;

  // Texts
  final Color text;

  // Widgets
  final Color circularProgressIndicator;
  final Color divider;
  final Color endOfListIndicator;
  final Color imagePlaceholder;
}
