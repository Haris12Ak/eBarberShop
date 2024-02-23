import 'dart:convert';

import 'package:ebarbershop_desktop/models/rezervacije/rezervacija_usluge.dart';
import 'package:ebarbershop_desktop/models/rezervacije/usluge_rezervacije_info.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RezervacijaUslugeProvider extends BaseProvider<RezervacijaUsluge> {
  late String _baseUrl;
  RezervacijaUslugeProvider() : super('RezervacijaUsluge') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7076/");
  }

  @override
  RezervacijaUsluge fromJson(item) {
    return RezervacijaUsluge.fromJson(item);
  }

  Future<SearchResult<UslugeRezervacijeInfo>> GetRezervacije(int uslugaId,
      {dynamic filter}) async {
        
    String endpointUslugeRezervacije = "GetRezervacijeByUslugaId";

    var url = "$_baseUrl$endpointUslugeRezervacije/$uslugaId";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<UslugeRezervacijeInfo>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(UslugeRezervacijeInfo.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
