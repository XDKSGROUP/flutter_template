import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  static Future<void> checkLogin(BuildContext context) async {
    print('checkLogin');
    print(currentUser);
    if (currentUser != null && currentUser.id != null) return;
    if (MyGlobal.token == null || MyGlobal.token.isEmpty) {
      var prefs = await SharedPreferences.getInstance();
      MyGlobal.token = prefs.getString(Locate.tokenText);
    }
    if (MyGlobal.token != null && MyGlobal.token.isNotEmpty) {
      bool isLogin = await userInfo();
      if (isLogin) return;
    }
    MyRouter.pushNoBack(context, 'login');
  }

  static login(name, password) async {
    var url = "/sso/login";
    var data = {"username": "$name", "password": "$password"};

    String result = await MyHttpRequest.post(url, data);
    Map json = jsonDecode(result);
    print(json);
    if (json["code"] == 200) {
      MyGlobal.token = json["data"]["tokenHead"] + " " + json["data"]["token"];
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) => value.setString(Locate.tokenText, MyGlobal.token));
      return null;
    } else
      return json["message"];
  }

  static loginOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(Locate.tokenText);
  }

  static userInfo() async {
    var url = "/sso/info";
    String result = await MyHttpRequest.get(url);
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
