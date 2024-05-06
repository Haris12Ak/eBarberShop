import 'package:ebarbershop_mobile/models/payment_detail/payment_detail.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class PaymentDetailProvider extends BaseProvider {
  PaymentDetailProvider() : super('PaymentDetail');

  @override
  fromJson(item) {
    return PaymentDetail.fromJson(item);
  }
}
