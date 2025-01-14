import '../theme.dart';

//TODO: Review namings
class AppTypographyData {
  const AppTypographyData({
    required this.buttonLabel,
    required this.strongLabel,
    required this.headingLarge,
    required this.bodyRegular,
    required this.headingMedium,
    required this.bodyMedium,
    required this.bodyXSmall,
  });

  factory AppTypographyData.regular() => const AppTypographyData(
        buttonLabel: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        strongLabel: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          decoration: TextDecoration.none,
        ),
        headingLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 30,
          decoration: TextDecoration.none,
        ),
        bodyRegular: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        headingMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 25,
          decoration: TextDecoration.none,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        bodyXSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 10,
          decoration: TextDecoration.none,
        ),
      );

  factory AppTypographyData.small() => const AppTypographyData(
        buttonLabel: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        strongLabel: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          decoration: TextDecoration.none,
        ),
        headingLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 30,
          decoration: TextDecoration.none,
        ),
        bodyRegular: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        headingMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 25,
          decoration: TextDecoration.none,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        bodyXSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 10,
          decoration: TextDecoration.none,
        ),
      );

  final TextStyle buttonLabel;
  final TextStyle strongLabel;
  final TextStyle headingLarge;
  final TextStyle bodyRegular;
  final TextStyle headingMedium;
  final TextStyle bodyMedium;
  final TextStyle bodyXSmall;
}
