import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fulate/config/palette.dart';
import 'package:fulate/screens/screens.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class MyRouter {
  static const homePage = '/';
  static const personPage = 'person';

  Widget _getPage(String url, dynamic params) {
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
      }
    }
    return null;
  }

  MyRouter.push(BuildContext context, String url, {dynamic params}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
