import 'package:http/http.dart' as http;

import 'commons.dart';

class MyHttpRequest {
  static final String baseUrl = "https://portaltestapi.gup-go.club";

  static Future<dynamic> get(String url) async {
    http.Response response = await http
        .get(baseUrl + url, headers: {"authorization": MyGlobal.token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }

  static Future<dynamic> post(String url, data) async {
    http.Response response = await http.post(baseUrl + url,
        body: data, headers: {"authorization": MyGlobal.token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }
}
