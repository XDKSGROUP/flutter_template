import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/config/config.dart';
import 'package:fulate/models/models.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
          child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'username'),
            controller: this._username,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'password'),
            controller: this._password,
          ),
          MaterialButton(
            onPressed: () => login(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text(Locate.loginButtonText),
            splashColor: Colors.blueAccent,
          ),
          MaterialButton(
            onPressed: () => loginOut(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text(Locate.loginOutButtonText),
            splashColor: Colors.blueAccent,
          ),
          new Text("currentUser:${jsonEncode(context.watch<CurrentUser>())}"),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: '13253495869');
    _password = TextEditingController(text: '112233');
  }

  TextEditingController _username;
  TextEditingController _password;

  login() async {
    await UserApi.login(this._username.text, this._password.text);
    Navigator.of(context).pushNamedAndRemoveUntil('/nav', (route) => false);
  }

  loginOut() async {
    UserApi.loginOut(context);
  }
}
