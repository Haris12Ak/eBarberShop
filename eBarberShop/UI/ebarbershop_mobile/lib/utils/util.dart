import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Authorization {
  static int? korisnikId;
  static String? username;
  static String? password;
}

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}

String formatDate(dynamic) {
  var f = DateFormat('yyyy-MM-dd HH:mm');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}

String formatNumber(dynamic) {
  var f = NumberFormat('###.00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

String getDateFormat(dynamic) {
  var f = DateFormat('yyyy/MM/dd');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}

String getTimeFormat(dynamic){
  var f = DateFormat('HH:mm');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}