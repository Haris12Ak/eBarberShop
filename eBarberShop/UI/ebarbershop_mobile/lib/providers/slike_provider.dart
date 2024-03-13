import 'package:ebarbershop_mobile/models/slike/slike.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class SlikeProvider extends BaseProvider<Slike> {
  SlikeProvider() : super('Slike');

  @override
  Slike fromJson(item) {
    return Slike.fromJson(item);
  }
}
