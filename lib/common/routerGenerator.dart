import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/screens/screens.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    if (routeSettings.name.startsWith('https://') ||
        routeSettings.name.startsWith('http://')) {
      return _webViewPage(routeSettings.name);
    }

    switch (routeSettings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case personPage:
        return MaterialPageRoute(builder: (_) => PersonPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case navPage:
        return MaterialPageRoute(builder: (_) => NavPage());
      default:
        return _errorRoute(routeSettings.name);
    }
  }

  static Route<dynamic> _errorRoute(name) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("error route"),
        ),
        body: Center(
          child: Text(name),
        ),
      );
    });
  }

  static _webViewPage(url) {
    return MaterialPageRoute(builder: (_) {
      return WebviewScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(_),
          ),
        ),
        url: url,
      );
    });
  }

  static const homePage = '/';
  static const navPage = '/nav';
  static const personPage = '/person';
  static const loginPage = '/login';
  static const whiteListWithLogin = [loginPage];
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  void checkLogin(url, context) {
    if (whiteListWithLogin.contains(url)) return;
    UserApi.checkLogin(context);
  }
}
