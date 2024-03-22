import 'dart:convert';

import 'package:ebarbershop_mobile/models/ocjene/ocjene.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class OcjeneProvider extends BaseProvider<Ocjene> {
  late String _baseUrl;
  OcjeneProvider() : super('Ocjene') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
  }

  @override
  Ocjene fromJson(item) {
    return Ocjene.fromJson(item);
  }

  Future<SearchResult<Ocjene>> GetOcjene(int uposlenikId) async {
    String endpointOcjene = "GetOcjeneByUposlenikId";

    var url = "$_baseUrl$endpointOcjene/$uposlenikId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Ocjene>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(Ocjene.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
