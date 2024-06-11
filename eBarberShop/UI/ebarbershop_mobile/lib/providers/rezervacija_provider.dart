import 'dart:convert';

import 'package:ebarbershop_mobile/models/rezervacija/rezervacija.dart';
import 'package:ebarbershop_mobile/models/rezervacija/termini_korisnika_info.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija> {
  late String _baseUrl;

  RezervacijaProvider() : super('Rezervacija') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");
  }

  @override
  Rezervacija fromJson(item) {
    return Rezervacija.fromJson(item);
  }

  Future<SearchResult<TerminiKorisnikaInfo>> getTermineByKorisnikId(
      int korisnikId) async {
    String endpointTerminiKorisnikaUrl = "GetTermineByKorisnikId";

    var url = "$_baseUrl$endpointTerminiKorisnikaUrl/$korisnikId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<TerminiKorisnikaInfo>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(TerminiKorisnikaInfo.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
