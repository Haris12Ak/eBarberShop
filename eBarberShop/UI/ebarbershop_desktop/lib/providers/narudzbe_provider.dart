import 'dart:convert';

import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/izvjestaj_narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class NarudzbeProvider extends BaseProvider<Narudzbe> {
  late String _baseUrl;
  NarudzbeProvider() : super('Narudzbe') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7076/");
  }

  @override
  Narudzbe fromJson(item) {
    return Narudzbe.fromJson(item);
  }

  Future<IzvjestajNarudzbe> getIzvjestajNarudzbe({dynamic filter}) async {
    String endpointIzvjestajNarudzbe = "IzvjestajNarudzbe";

    var url = "$_baseUrl$endpointIzvjestajNarudzbe";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      IzvjestajNarudzbe izvjestajNarudzbe = IzvjestajNarudzbe.fromJson(data);

      return izvjestajNarudzbe;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
