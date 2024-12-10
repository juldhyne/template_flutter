import 'base.dart';

class ProductionEnvironment implements BaseEnvironment {
  @override
  String get name => 'prod';

  //TODO: define production url
  @override
  String get url => '';
}
