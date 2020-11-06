import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_qrcode/flutter_plugin_qrcode.dart';
import 'package:fulate/common/commons.dart';
import 'package:fulate/models/models.dart';
import 'package:fulate/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: getImage,
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: getQrcodeState,
          ),
        ],
      ),
      drawer: new MyDrawer(
        function: () => MyRouter.push(context, "person"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(_qrcode),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _counter++;
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  int _counter = 0;
  File _image;
  final picker = ImagePicker();
  String _qrcode = "";
  // final picker = ImagePicker();
  // final pickedFile = await picker.getImage(source: ImageSource.camera);
  // final pickedFile2 = await picker.getImage(source: ImageSource.gallery);
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _image.copy('newPath'); //无用,保持_image被引用
      }
    });
  }

  Future<void> getQrcodeState() async {
    String qrcode;
    try {
      qrcode = await FlutterPluginQrcode.getQRCode;
    } on PlatformException {
      qrcode = '';
    }

    if (!mounted) return;

    setState(() {
      _qrcode = qrcode;
    });
  }
}
