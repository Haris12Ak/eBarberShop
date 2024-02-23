import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija>{
  RezervacijaProvider() : super('Rezervacija');

  @override
  Rezervacija fromJson(item) {
    return Rezervacija.fromJson(item);
  }
}