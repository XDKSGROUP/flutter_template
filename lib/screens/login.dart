import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/config/config.dart';

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
            child: Text(Locate.loginButtonText),
            splashColor: Colors.blueAccent,
          ),
          MaterialButton(
            onPressed: () => loginOut(),
            color: Colors.teal,
            textColor: Colors.white,
            child: Text(Locate.loginOutButtonText),
            splashColor: Colors.blueAccent,
          )
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
    String result =
        await UserApi.login(this._username.text, this._password.text);
    if (result != null && result.isNotEmpty) {
      print(result);
    } else {
      MyRouter.pushNoBack(context, 'nav');
    }
  }

  loginOut() async {
    UserApi.loginOut();
    MyRouter.pushNoBack(context, 'login');
  }
}
