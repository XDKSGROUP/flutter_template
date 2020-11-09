import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/config/palette.dart';
import 'package:fulate/screens/screens.dart';

class MyRouter {
  static const homePage = '/';
  static const navPage = 'nav';
  static const personPage = 'person';
  static const loginPage = 'login';
  static const whiteListWithLogin = [loginPage];

  Widget _getPage(String url, dynamic params, BuildContext context) {
    checkLogin(url, context);
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return WebviewScaffold(
        url: url,
        appBar: AppBar(
          title: Text(params['title']),
          backgroundColor: Palette.myGreen,
        ),
      );
    } else {
      switch (url) {
        case homePage:
          return HomePage();
        case personPage:
          return PersonPage();
        case loginPage:
          return LoginPage();
        case navPage:
          return NavPage();
      }
    }
    return null;
  }

  MyRouter.push(BuildContext context, String url, {dynamic params}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params, context);
    }));
  }
  MyRouter.pushNoBack(BuildContext context, String url, {dynamic params}) {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      return _getPage(url, params, context);
    }), (route) => route == null);
  }

  void checkLogin(url, context) {
    if (whiteListWithLogin.contains(url)) return;
    UserApi.checkLogin(context);
  }
}
