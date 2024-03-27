import 'dart:convert';

import 'package:ebarbershop_mobile/models/rezervacija/rezervacija.dart';
import 'package:ebarbershop_mobile/models/rezervacija/termini_korisnika_info.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class RezervacijaProvider extends BaseProvider<Rezervacija> {
  late String _baseUrl;

  RezervacijaProvider() : super('Rezervacija') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7076/");
  }

  @override
  Rezervacija fromJson(item) {
    return Rezervacija.fromJson(item);
  }

  Future<Rezervacija> rezervisiTermin(int uslugaId, dynamic request) async {
    String endpointRezervisiTermin = "RezervisiTermin";

    var url = "$_baseUrl$endpointRezervisiTermin/$uslugaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      return Rezervacija.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<SearchResult<TerminiKorisnikaInfo>> GetTermineByKorisnikId(
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
