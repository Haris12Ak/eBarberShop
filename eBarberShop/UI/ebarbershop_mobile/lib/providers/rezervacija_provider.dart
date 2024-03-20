import 'dart:convert';

import 'package:ebarbershop_mobile/models/rezervacija/rezervacija.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija> {
  late String _baseUrl;

  RezervacijaProvider() : super('Rezervacija') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
  }

  @override
  Rezervacija fromJson(item) {
    return Rezervacija.fromJson(item);
  }

  Future<Rezervacija> rezervisiTermin(int uslugaId, dynamic request) async {
    String endpointRezervisiTermin = "RezervisiTermin";

    var url = "$_baseUrl$endpointRezervisiTermin/$uslugaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      return Rezervacija.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
}
