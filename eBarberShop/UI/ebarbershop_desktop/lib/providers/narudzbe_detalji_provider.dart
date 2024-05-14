import 'dart:convert';

import 'package:ebarbershop_desktop/models/narudzbeDetalji/narudzbe_detalji.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class NarudzbeDetaljiProvider extends BaseProvider {
  late String _baseUrl;
  NarudzbeDetaljiProvider() : super("NarudzbeDetalji") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7076/");
  }

  @override
  fromJson(item) {
    return NarudzbeDetalji.fromJson(item);
  }

  Future<SearchResult<NarudzbeDetalji>> getNarudzbeDetalji(
      int narudzbaId) async {
    String endpointNarudzbeDetalji = "GetNarudzbeDetaljiByNarudzbaId";

    var url = "$_baseUrl$endpointNarudzbeDetalji/$narudzbaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<NarudzbeDetalji>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(NarudzbeDetalji.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
