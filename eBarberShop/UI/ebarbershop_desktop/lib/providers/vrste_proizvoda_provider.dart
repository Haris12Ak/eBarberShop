import 'package:ebarbershop_desktop/models/vrsteProizvoda/vrste_proizvoda.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class VrsteProizvodaProvider extends BaseProvider<VrsteProizvoda> {
  VrsteProizvodaProvider() : super('VrsteProizvoda');

  @override
  VrsteProizvoda fromJson(item) {
    return VrsteProizvoda.fromJson(item);
  }
}
