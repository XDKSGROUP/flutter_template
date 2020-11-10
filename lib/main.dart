import 'package:flutter/material.dart';
import 'package:fulate/models/models.dart';
import 'package:fulate/screens/nav.dart';
import 'package:provider/provider.dart';
import 'common/commons.dart';
import 'config/config.dart';

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
      onGenerateRoute: RouterGenerator.generateRoute,
      navigatorKey: RouterGenerator.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
