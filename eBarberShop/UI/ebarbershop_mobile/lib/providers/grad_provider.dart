import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_mobile/models/grad/grad.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class GradProvider with ChangeNotifier {
  String? _baseUrl;

  HttpClient client = HttpClient();
  IOClient? http;

  GradProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7076/");

    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<SearchResult<Grad>> get() async {
    var endpoint = "Grad";

    var url = "$_baseUrl$endpoint";

    var uri = Uri.parse(url);

    var response = await http!.get(uri);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Grad>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(Grad.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknow Error");
    }
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
