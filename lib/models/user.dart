import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class User with ChangeNotifier {
  User({
    @required this.id,
    String name = "",
    String tel = "",
    this.imageUrl = 'assets/images/user.jpg',
    this.backgroundImageUrl = 'assets/images/bgi.jpg',
  })  : this._name = name,
        this._tel = tel;

  int id;
  String imageUrl;
  String backgroundImageUrl;

  String _tel = '';
  get tel => _tel;
  set tel(String email) {
    _tel = email;
    notifyListeners();
  }

  String _name = '';
  get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }
}
