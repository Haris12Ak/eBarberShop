import 'dart:convert';

import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/base_provider.dart';

class NarudzbeProvider extends BaseProvider {
  late String _baseUrl;

  NarudzbeProvider() : super('Narudzbe') {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");
  }

  @override
  fromJson(item) {
    return Narudzbe.fromJson(item);
  }

  Future<SearchResult<Narudzbe>> getNarudzbeByKorisnikId(int korisnikId,
      {DateTime? datumNarudzbe}) async {
    String endpointGetNarudzbeByKorisnik = "GetNarudzbeByKorisnikId";

    var url = "$_baseUrl$endpointGetNarudzbeByKorisnik/$korisnikId";

    if (datumNarudzbe != null) {
      var queryString = "datumNarudzbe=";
      url = "$url?$queryString$datumNarudzbe";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Narudzbe>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(Narudzbe.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<Narudzbe> otkaziNarudzbu(int narudzbaId) async {
    String endpointOtkaziNarudzbu = "OtkaziNarudzbu";
    var url = "$_baseUrl$endpointOtkaziNarudzbu/$narudzbaId";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.put(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      return Narudzbe.fromJson(data);
    } else {
      throw Exception("Unknow Error");
    }
  }
}
