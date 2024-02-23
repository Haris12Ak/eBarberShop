import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class UslugaProvider extends BaseProvider<Usluga>{
  UslugaProvider() : super('Usluga');

  @override
  Usluga fromJson(item) {
    return Usluga.fromJson(item);
  }

}