import 'dart:convert';

import 'package:fulate/config/config.dart';
import 'package:http/http.dart' as http;

class MyHttpRequest {
  static Map<String, String> get headers =>
      {MyGlobal.authHeaderText: MyGlobal.token};

  static Future<dynamic> get(String url) async {
    http.Response response =
        await http.get(MyGlobal.baseUrl + url, headers: headers);
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
      return parse(body);
    } else {
      print(response);
    }
  }

  static Future<dynamic> post(String url, data) async {
    http.Response response =
        await http.post(MyGlobal.baseUrl + url, body: data, headers: headers);
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
      return parse(body);
    } else {
      print(response);
    }
  }

  static parse(String body) {
    Map json = jsonDecode(body);
    String code = json["code"].toString();
    if (code != "200") {
      print(json);
    }
    return json["data"];
  }
}
