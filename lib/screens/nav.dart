import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulate/api/api.dart';

import 'screens.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    if (_selectIndex == 0) UserApi.checkLogin(context);
    return Scaffold(
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        iconSize: 24,
        currentIndex: _selectIndex,
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [
        HomePage(),
        LoginPage(),
        PersonPage(),
        PersonPage(),
        PersonPage(),
      ];
    }
    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              label: item.name,
              activeIcon:
                  Image.asset(item.activeIcon, width: 30.0, height: 30.0)))
          .toList();
    }
  }

  int _selectIndex = 0;
  List<Widget> pages;
  List<BottomNavigationBarItem> itemList;

  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png',
        'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png',
        'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png',
        'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png',
        'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png',
        'assets/images/ic_tab_profile_normal.png')
  ];

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}
