import 'package:ebarbershop_desktop/models/novosti/novosti.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class NovostiProvider extends BaseProvider<Novosti> {
  NovostiProvider() : super('Novosti');
  
  @override
  Novosti fromJson(item) {
    return Novosti.fromJson(item);
  }
}
