import 'package:ebarbershop_mobile/models/novosti/novosti.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class NovostiProvider extends BaseProvider<Novosti> {
  NovostiProvider() : super('Novosti');

  @override
  Novosti fromJson(item) {
    return Novosti.fromJson(item);
  }
}
