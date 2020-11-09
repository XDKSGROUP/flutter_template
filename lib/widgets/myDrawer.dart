import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/models/models.dart';

class MyDrawer extends StatelessWidget {
  final Function function;
  final CurrentUser user;
  MyDrawer({
    Key key,
    this.user,
    this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(user.name),
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
            title: new Text("搜索"),
            trailing: new Icon(Icons.search),
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
