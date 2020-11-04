import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/palette.dart';
import 'package:fulate/screens/screens.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class MyRouter {
  static const homePage = '/';
  static const navPage = 'nav';
  static const personPage = 'person';
  static const loginPage = 'login';

  Widget _getPage(String url, dynamic params, BuildContext context) {
    if (url != loginPage) MyHttpRequest.checkLogin(context);
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
}
