import 'dart:convert';

import 'package:fulate/config/config.dart';
import 'package:http/http.dart' as http;

import 'commons.dart';

class MyHttpRequest {
  static final client = http.Client();

  static get headers => {MyGlobal.authHeaderText: MyGlobal.token};

  static Future<dynamic> get(String url) async {
    var response = await client.get(MyGlobal.baseUrl + url, headers: headers);
    if (response.statusCode == 200) {
      return parse(response.body);
    } else {
      eventBus.fire(HttpErrorEvent(response.statusCode, response.body));
    }
  }

  static Future<dynamic> post(String url, data) async {
    var response =
        await client.post(MyGlobal.baseUrl + url, body: data, headers: headers);
    if (response.statusCode == 200) {
      return parse(response.body);
    } else {
      eventBus.fire(HttpErrorEvent(response.statusCode, response.body));
    }
  }

  static parse(String body) {
    var json = jsonDecode(body);
    int code = json["code"];
    if (code == 200) {
      return json["data"];
    } else {
      eventBus.fire(HttpInternalErrorEvent(code, json["message"].toString()));
    }
  }
}
