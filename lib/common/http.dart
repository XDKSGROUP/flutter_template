import 'package:fulate/config/config.dart';
import 'package:http/http.dart' as http;

class MyHttpRequest {
  static Future<dynamic> get(String url) async {
    http.Response response = await http.get(MyGlobal.baseUrl + url,
        headers: {MyGlobal.authHeaderText: MyGlobal.token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }

  static Future<dynamic> post(String url, data) async {
    http.Response response = await http.post(MyGlobal.baseUrl + url,
        body: data, headers: {MyGlobal.authHeaderText: MyGlobal.token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }
}
