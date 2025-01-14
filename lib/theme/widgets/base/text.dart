import '../../theme.dart';

enum AppTextLevelEnum {
  body,
  title,
  button,
}

extension XAppTextLevelEnum on AppTextLevelEnum {
  TextStyle getStyle(BuildContext context) {
    final theme = AppTheme.of(context);
    switch (this) {
      case AppTextLevelEnum.body:
        return theme.typography.body;
      case AppTextLevelEnum.title:
        return theme.typography.title;
      case AppTextLevelEnum.button:
        return theme.typography.button;
    }
  }
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.level = AppTextLevelEnum.body,
    this.color,
    this.fontSize,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.selectable = false,
    this.overflow = TextOverflow.ellipsis,
    this.underlined = false,
  });

  final String text;
  final AppTextLevelEnum level;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool selectable;
  final TextOverflow overflow;
  final bool underlined;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: level.getStyle(context).copyWith(
            color: color ?? theme.colors.text,
            fontSize: fontSize,
            overflow: overflow,
            decoration: underlined ? TextDecoration.underline : null,
            decorationColor: color ?? theme.colors.text,
          ),
    );
  }
}
