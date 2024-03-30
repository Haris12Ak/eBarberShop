import 'dart:convert';

import 'package:ebarbershop_mobile/models/korisnik/korisnik.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  String? _baseUrl;

  KorisnikProvider() : super('Korisnici') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
  }

  @override
  Korisnik fromJson(item) {
    return Korisnik.fromJson(item);
  }

  @override
  Future<Korisnik> insert(request) async {
    var endpoint = "Korisnici";
    var url = "$_baseUrl$endpoint";
    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
}
