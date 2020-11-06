import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserApi {
  static Future<void> checkLogin(BuildContext context) async {
    print('checkLogin');
    if (context.watch<CurrentUser>().id != null) return;
    if (MyGlobal.token == null || MyGlobal.token.isEmpty) {
      var prefs = await SharedPreferences.getInstance();
      MyGlobal.token = prefs.getString(Locate.tokenText);
    }
    if (MyGlobal.token != null && MyGlobal.token.isNotEmpty) {
      bool isLogin = await userInfo(context);
      if (isLogin) return;
    }
    MyRouter.pushNoBack(context, 'login');
  }

  static login(name, password) async {
    var url = "/sso/login";
    var data = {"username": "$name", "password": "$password"};

    String result = await MyHttpRequest.post(url, data);
    Map json = jsonDecode(result);
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

  static userInfo(BuildContext context) async {
    var url = "/sso/info";
    String result = await MyHttpRequest.get(url);
    Map json = jsonDecode(result);
    if (json["code"] == 200) {
      CurrentUser user = context.read<CurrentUser>();
      user.id = json["data"]["id"];
      user.name = json["data"]["nickname"];
      user.tel = json["data"]["username"];
      return true;
    }
  }
}
