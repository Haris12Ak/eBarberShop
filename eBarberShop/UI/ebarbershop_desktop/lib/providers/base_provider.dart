import 'dart:convert';

import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseProvider<T> with ChangeNotifier {
  String? _baseUrl;
  String? _endpoint;

  BaseProvider(String endpoint) {
    _endpoint = endpoint;

    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7076/");
  }

  Future<SearchResult<T>> get() async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknow Error");
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
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

  T fromJson(item) {
    throw Exception("Not implemented!");
  }
}
