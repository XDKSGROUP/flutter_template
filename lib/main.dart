import 'package:flutter/material.dart';
import 'config/config.dart';
import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Location.mainTitle,
      home: NavPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
