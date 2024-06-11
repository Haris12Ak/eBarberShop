import 'dart:convert';

import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_detalji.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class NarudzbeDetaljiProvider extends BaseProvider {
  late String _baseUrl;

  NarudzbeDetaljiProvider() : super('NarudzbeDetalji') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");
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

    var response = await http!.get(uri, headers: headers);

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
