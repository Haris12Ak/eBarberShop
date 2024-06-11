import 'dart:convert';
import 'dart:core';

import 'package:ebarbershop_desktop/models/korisnik/korisnik.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "Login";

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7076/");
  }

  Future<dynamic> login() async {
    var url =
        "$_baseUrl$_endpoint?Username=${Authorization.username}&Password=${Authorization.password}";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      
      return Korisnik.fromJson(data);
    } else {
      return null;
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
}
