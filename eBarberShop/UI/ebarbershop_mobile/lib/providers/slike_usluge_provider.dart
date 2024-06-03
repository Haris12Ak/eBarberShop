import 'dart:convert';

import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/slike_usluge/slike_usluge.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class SlikeUslugeProvider extends BaseProvider<SlikeUsluge> {
  late String _baseUrl;
  SlikeUslugeProvider() : super('SlikeUsluge') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
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

    var response = await http!.get(uri, headers: headers);

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
