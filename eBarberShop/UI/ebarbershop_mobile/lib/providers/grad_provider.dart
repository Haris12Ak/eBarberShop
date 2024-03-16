import 'package:ebarbershop_mobile/models/grad/grad.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class GradProvider extends BaseProvider<Grad> {
  GradProvider() : super('Grad');

  @override
  Grad fromJson(item) {
    return Grad.fromJson(item);
  }
}
