import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RecenzijeProvider extends BaseProvider<Recenzije>{
  RecenzijeProvider() : super('Recenzije');

  @override
  Recenzije fromJson(item) {
    return Recenzije.fromJson(item);
  }
}