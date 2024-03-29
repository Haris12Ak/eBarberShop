import 'package:ebarbershop_mobile/models/proizvodi/vrste_proizvoda.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class VrsteProizvodaProvider extends BaseProvider<VrsteProizvoda> {
  VrsteProizvodaProvider() : super('VrsteProizvoda');

  @override
  VrsteProizvoda fromJson(item) {
    return VrsteProizvoda.fromJson(item);
  }
}