import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/data/data.dart';
import 'package:fulate/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpRequest {
  static final String baseUrl = "https://portaltestapi.gup-go.club";
  static String token;

  static Future<dynamic> get(String url) async {
    http.Response response =
        await http.get(baseUrl + url, headers: {"authorization": token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }

  static Future<dynamic> post(String url, data) async {
    http.Response response = await http
        .post(baseUrl + url, body: data, headers: {"authorization": token});
    int statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
    } else {
      print(response);
    }
    return body;
  }

  static Future<void> checkLogin(BuildContext context) async {
    print('checkLogin');
    print(currentUser);
    if (currentUser != null && currentUser.id != null) return;
    if (token == null || token.isEmpty) {
      var prefs = await SharedPreferences.getInstance();
      token = prefs.getString(Location.tokenText);
    }
    if (token != null && token.isNotEmpty) {
      bool isLogin = await userInfo();
      if (isLogin) return;
    }
    MyRouter.pushNoBack(context, 'login');
  }

  static login(name, password) async {
    var url = "/sso/login";
    var data = {"username": "$name", "password": "$password"};

    String result = await post(url, data);
    Map json = jsonDecode(result);
    print(json);
    if (json["code"] == 200) {
      token = json["data"]["tokenHead"] + " " + json["data"]["token"];
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) => value.setString(Location.tokenText, token));
      return null;
    } else
      return json["message"];
  }

  static loginOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(Location.tokenText);
  }

  static userInfo() async {
    var url = "/sso/info";
    String result = await get(url);
    Map json = jsonDecode(result);
    print(json);
    if (json["code"] == 200) {
      currentUser = new User(
          id: json["data"]["id"],
          name: json["data"]["nickname"],
          tel: json["data"]["username"]);
      return true;
    }
  }
}
