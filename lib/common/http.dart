import 'dart:convert';

import 'package:fulate/config/config.dart';
import 'package:http/http.dart' as http;

class MyHttpRequest {
  static final client = http.Client();

  static get headers => {MyGlobal.authHeaderText: MyGlobal.token};

  static Future<dynamic> get(String url) async {
    var response = await client.get(MyGlobal.baseUrl + url, headers: headers);
    if (response.statusCode == 200) {
      return parse(response.body);
    } else {
      print(response);
    }
  }

  static Future<dynamic> post(String url, data) async {
    var response =
        await client.post(MyGlobal.baseUrl + url, body: data, headers: headers);
    if (response.statusCode == 200) {
      return parse(response.body);
    } else {
      print(response);
    }
  }

  static parse(String body) {
    var json = jsonDecode(body);
    String code = json["code"].toString();
    if (code != "200") {
      print("ui should show errorMessage");
      print(json);
    }
    return json["data"];
  }
}
