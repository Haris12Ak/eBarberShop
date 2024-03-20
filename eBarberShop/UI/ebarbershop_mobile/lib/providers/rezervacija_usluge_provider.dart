import 'package:ebarbershop_mobile/models/rezervacija/rezervacija_usluge.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RezervacijaUslugeProvider extends BaseProvider<RezervacijaUsluge> {
  RezervacijaUslugeProvider() : super('RezervacijaUsluge');

  @override
  RezervacijaUsluge fromJson(item) {
    return RezervacijaUsluge.fromJson(item);
  }
}
