import '../theme.dart';

class AppTypographyData {
  const AppTypographyData({
    required this.title,
    required this.body,
    required this.button,
  });

  factory AppTypographyData.regular() => const AppTypographyData(
        body: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        title: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 30,
          decoration: TextDecoration.none,
        ),
        button: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
      );

  factory AppTypographyData.small() => const AppTypographyData(
        body: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        title: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 30,
          decoration: TextDecoration.none,
        ),
        button: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
      );

  final TextStyle body;
  final TextStyle title;
  final TextStyle button;
}
