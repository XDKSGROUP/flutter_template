import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            child: Text(Location.loginButtonText),
            splashColor: Colors.blueAccent,
          ),
          MaterialButton(
            onPressed: () => loginOut(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text(Location.loginOutButtonText),
            splashColor: Colors.blueAccent,
          )
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    this._username.text = '13253495869';
    this._password.text = '112233';
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  login() async {
    String result =
        await MyHttpRequest.login(this._username.text, this._password.text);
    if (result != null && result.isNotEmpty) {
      print(result);
    } else {
      MyRouter.pushNoBack(context, 'nav');
    }
  }

  loginOut() async {
    MyHttpRequest.loginOut();
    MyRouter.pushNoBack(context, 'login');
  }
}
