import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class NarudzbeProvider extends BaseProvider {
  NarudzbeProvider() : super('Narudzbe');

  @override
  fromJson(item) {
    return Narudzbe.fromJson(item);
  }
}
