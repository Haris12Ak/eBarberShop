import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';

class UposlenikProvider extends BaseProvider<Uposlenik>{
  UposlenikProvider() : super('Uposlenik');

  @override
  Uposlenik fromJson(item) {
    return Uposlenik.fromJson(item);
  }

}