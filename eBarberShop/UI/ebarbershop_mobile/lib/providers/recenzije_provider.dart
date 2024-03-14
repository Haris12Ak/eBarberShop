import 'dart:convert';

import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RecenzijeProvider extends BaseProvider<Recenzije> {
  late String _baseUrl;
  RecenzijeProvider() : super('Recenzije') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
  }

  @override
  Recenzije fromJson(item) {
    return Recenzije.fromJson(item);
  }

  Future<SearchResult<Recenzije>> GetRecenzijeByKorisnikId(
      int korisnikId) async {
    String endpointRecenzijeKorisnikUrl = "GetRecenzijeByKorisnikId";

    var url = "$_baseUrl$endpointRecenzijeKorisnikUrl/$korisnikId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Recenzije>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(Recenzije.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
