import 'package:flutter/material.dart';
import 'package:fulate/models/models.dart';
import 'package:provider/provider.dart';
import 'config/config.dart';
import 'screens/screens.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CurrentUser()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Locate.mainTitle,
      home: NavPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
