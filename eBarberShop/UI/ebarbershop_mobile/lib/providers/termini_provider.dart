import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/termini/termini.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class TerminiProvider with ChangeNotifier {
  String? _baseUrl;
  final String _endpoint = 'GetTermine';

  HttpClient client = HttpClient();
  IOClient? http;

  TerminiProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");

    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<SearchResult<Termini>> getTermine() async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Termini>();

      result.count = result.count;

      for (var item in data) {
        result.result.add(Termini.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknow Error");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
