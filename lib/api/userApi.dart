import 'package:flutter/widgets.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserApi {
  static login(name, password) async {
    var url = "/sso/login";
    var data = {"username": "$name", "password": "$password"};

    Map json = await MyHttpRequest.post(url, data);
    if (json == null) return;
    MyGlobal.token = json["tokenHead"] + " " + json["token"];
    SharedPreferences.getInstance()
        .then((value) => value.setString(Locate.tokenName, MyGlobal.token));
    RouterGenerator.navigatorKey.currentState
        .pushNamedAndRemoveUntil("/nav", (route) => false);
  }

  static loginOut(context) async {
    MyGlobal.token = null;
    SharedPreferences.getInstance()
        .then((value) => value.remove(Locate.tokenName));
    Provider.of<CurrentUser>(context, listen: false).update(new CurrentUser());
  }

  static checkLogin(BuildContext context) async {
    print("check login");
    if (Provider.of<CurrentUser>(context, listen: false).isLogin) return;
    if (MyGlobal.token?.isEmpty ?? true) {
      var prefs = await SharedPreferences.getInstance();
      MyGlobal.token = prefs.getString(Locate.tokenName);
    }
    if (MyGlobal.token?.isNotEmpty ?? false) {
      await userInfo(context);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Provider.of<CurrentUser>(context, listen: false).isLogin)
        RouterGenerator.navigatorKey.currentState
            .pushNamedAndRemoveUntil("/login", (route) => false);
    });
  }

  static userInfo(BuildContext context) async {
    var url = "/sso/info";
    await MyHttpRequest.get(url).then((value) =>
        Provider.of<CurrentUser>(context, listen: false).fromJson(value));
  }
}
