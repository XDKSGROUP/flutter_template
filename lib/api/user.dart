import 'package:flutter/widgets.dart';
import 'package:fulate/api/base.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserApi extends BaseApi {
  static Future<void> checkLogin(BuildContext context) async {
    if (Provider.of<CurrentUser>(context, listen: false).isLogin) return;
    if (MyGlobal.token == null || MyGlobal.token.isEmpty) {
      var prefs = await SharedPreferences.getInstance();
      MyGlobal.token = prefs.getString(Locate.tokenText);
    }
    if (MyGlobal.token != null && MyGlobal.token.isNotEmpty) {
      userInfo(context);
    }
    Provider.of<CurrentUser>(context, listen: false).toLogin =
        (context) => MyRouter.pushNoBack(context, 'login');
  }

  static login(name, password) async {
    var url = "/sso/login";
    var data = {"username": "$name", "password": "$password"};

    Map json = await MyHttpRequest.post(url, data);
    MyGlobal.token = json["tokenHead"] + " " + json["token"];
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => value.setString(Locate.tokenText, MyGlobal.token));
    return null;
  }

  static loginOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(Locate.tokenText);
  }

  static userInfo(BuildContext context) async {
    var url = "/sso/info";
    await MyHttpRequest.get(url)
        .then((value) => context.read<CurrentUser>().fromJson(value));
  }
}
