import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/models/models.dart';

class MyDrawer extends StatelessWidget {
  final Function function;
  final Function function2;
  final CurrentUser user;
  MyDrawer({
    Key key,
    this.user,
    this.function,
    this.function2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(user.name + "(${user.id})"),
            accountEmail: Text(user.tel),
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new ExactAssetImage(user.imageUrl),
              ),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new ExactAssetImage(user.backgroundImageUrl),
              ),
            ),
          ),
          new ListTile(
            title: new Text("跳转"),
            trailing: new Icon(Icons.local_florist),
            onTap: function,
          ),
          new ListTile(
            title: new Text("webview"),
            trailing: new Icon(Icons.search),
            onTap: () =>
                Navigator.of(context).pushNamed('https://buguoheng.com'),
          ),
          new ListTile(
            title: new Text("退出登录"),
            trailing: new Icon(Icons.login_outlined),
            onTap: function2,
          ),
          new Divider(),
          new ListTile(
            title: new Text("设置"),
            trailing: new Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
