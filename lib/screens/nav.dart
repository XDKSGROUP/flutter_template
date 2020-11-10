import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/api/api.dart';
import 'package:fulate/common/commons.dart';

import 'screens.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 0) UserApi.checkLogin(context);
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (index) => changeIndex(index),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  static bool isInit = false;
  _init() {
    if (isInit) return;
    eventBus.on<HttpInternalErrorEvent>().listen((event) {
      print(event);
    });
    eventBus.on<HttpErrorEvent>().listen((event) {
      print('http error');
    });
    isInit = true;
  }

  final pages = [
    HomePage(),
    PersonPage(),
    PersonPage(),
    PersonPage(),
  ];
  int _currentIndex = 0;
  List<BottomNavigationBarItem> itemList = _itemList
      .map(
          (item) => BottomNavigationBarItem(icon: item.icon, label: item.lable))
      .toList();

  static final _itemList = [
    _Item('home', Icon(Icons.home)),
    _Item('message', Icon(Icons.message)),
    _Item('cart', Icon(Icons.shopping_cart)),
    _Item('person', Icon(Icons.person)),
  ];

  changeIndex(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}

class _Item {
  Icon icon;
  String lable;
  _Item(this.lable, this.icon);
}
