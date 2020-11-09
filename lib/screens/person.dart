import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/models/models.dart';
import 'package:provider/provider.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  TextEditingController name = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
        ),
        body: Column(
          children: [
            IconButton(
              icon: Icon(Icons.wallet_giftcard),
              onPressed: () => {},
            ),
            TextFormField(
              controller: this.name,
            ),
            FlatButton(
              onPressed: () {
                context.read<CurrentUser>().name = this.name.text;
              },
              child: Text("修改name Locality"),
            )
          ],
        ));
  }
}
