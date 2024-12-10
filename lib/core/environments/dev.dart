import 'base.dart';

class DevelopmentEnvironment implements BaseEnvironment {
  @override
  String get name => 'dev';

  @override
  String get url => 'http://localhost:8080/';
}
