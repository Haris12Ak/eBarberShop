import 'package:ebarbershop_mobile/models/korisnik/korisnik.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super('Korisnici');

  @override
  Korisnik fromJson(item) {
    return Korisnik.fromJson(item);
  }
}
