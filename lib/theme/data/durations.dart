class AppDurationsData {
  const AppDurationsData({
    required this.areAnimationEnabled,
    required this.quick,
    required this.regular,
  });

  factory AppDurationsData.regular() => const AppDurationsData(
        areAnimationEnabled: true,
        quick: Duration(milliseconds: 100),
        regular: Duration(milliseconds: 250),
      );

  final bool areAnimationEnabled;
  final Duration quick;
  final Duration regular;
}
