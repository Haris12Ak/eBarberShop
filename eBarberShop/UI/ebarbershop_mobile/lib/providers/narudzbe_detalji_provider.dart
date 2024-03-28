import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_detalji.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class NarudzbeDetaljiProvider extends BaseProvider {
  NarudzbeDetaljiProvider() : super('NarudzbeDetalji');

  @override
  fromJson(item) {
    return NarudzbeDetalji.fromJson(item);
  }
}
