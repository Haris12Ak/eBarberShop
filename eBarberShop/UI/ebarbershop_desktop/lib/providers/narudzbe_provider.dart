import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class NarudzbeProvider extends BaseProvider<Narudzbe>{
  NarudzbeProvider() : super('Narudzbe');

  @override
  Narudzbe fromJson(item) {
    return Narudzbe.fromJson(item);
  }
  
}