import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class ProizvodiProvider extends BaseProvider<Proizvodi>{
  ProizvodiProvider() : super('Proizvodi');
  
  @override
  Proizvodi fromJson(item) {
    return Proizvodi.fromJson(item);
  }
}