import 'dart:convert';

import 'package:ebarbershop_desktop/models/rezervacije/izvjestaj/izvjestaj_rezervacije.dart';
import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/termini/termini_uposlenika.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RezervacijaProvider extends BaseProvider<Rezervacija> {
  late String _baseUrl;
  RezervacijaProvider() : super('Rezervacija') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7076/");
  }

  @override
  Rezervacija fromJson(item) {
    return Rezervacija.fromJson(item);
  }

  Future<IzvjestajRezervacije> getIzvjestajRezervacije({dynamic filter}) async {
    String endpointIzvjestajRezervacije = "IzvjestajRezervacije";

    var url = "$_baseUrl$endpointIzvjestajRezervacije";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      IzvjestajRezervacije izvjestajRezervacije =
          IzvjestajRezervacije.fromJson(data);

      return izvjestajRezervacije;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<SearchResult<TerminiUposlenika>> getTermineUposlenika(
      {dynamic filter}) async {
    var endpoint = "GetTermineUposlenika";

    var url = "$_baseUrl$endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<TerminiUposlenika>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(TerminiUposlenika.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknow Error");
    }
  }
}
