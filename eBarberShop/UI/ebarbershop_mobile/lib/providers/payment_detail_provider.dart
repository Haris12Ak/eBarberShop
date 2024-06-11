import 'dart:convert';

import 'package:ebarbershop_mobile/models/payment_detail/payment_detail.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class PaymentDetailProvider extends BaseProvider {
  late String _baseUrl;
  PaymentDetailProvider() : super('PaymentDetail') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");
  }

  @override
  fromJson(item) {
    return PaymentDetail.fromJson(item);
  }

  Future<PaymentDetail?> getByNarudzbaId(int narudzbaId) async {
    String endpointGetByNarudzbaId = "GetByNarudzbaId";

    var url = "$_baseUrl$endpointGetByNarudzbaId/$narudzbaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return PaymentDetail.fromJson(data);
    } else {
      return null;
    }
  }
}
