import 'dart:convert';

import 'package:ebarbershop_desktop/models/korisnik/korisnik.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisnikProvider extends BaseProvider<Korisnik> {
  String? _baseUrl;

  KorisnikProvider() : super('Korisnici') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7076/");
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
    var response = await http.post(uri,
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
