import 'dart:convert';

import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/slike_usluge/slike_usluge.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class SlikeUslugeProvider extends BaseProvider<SlikeUsluge> {
  late String _baseUrl;
  SlikeUslugeProvider() : super('SlikeUsluge') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7076/");
  }

  @override
  SlikeUsluge fromJson(item) {
    return SlikeUsluge.fromJson(item);
  }

  Future<SearchResult<SlikeUsluge>> getSlike(int uslugaId) async {
    String endpointUslugeRezervacije = "GetSlikeByUslugaId";

    var url = "$_baseUrl$endpointUslugeRezervacije/$uslugaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<SlikeUsluge>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(SlikeUsluge.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
