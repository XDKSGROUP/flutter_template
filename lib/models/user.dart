import 'dart:convert';

import 'package:flutter/material.dart';

class CurrentUser with ChangeNotifier {
  CurrentUser({
    int id = 0,
    String name = "",
    String tel = "",
    this.imageUrl = 'assets/images/user.jpg',
    this.backgroundImageUrl = 'assets/images/bgi.jpg',
  })  : this._name = name,
        this._tel = tel;

  int _id;
  get id => _id;
  set id(int id) {
    _id = id;
    notifyListeners();
  }

  String _tel;
  get tel => _tel;
  set tel(String email) {
    _tel = email;
    notifyListeners();
  }

  String _name;
  get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  String imageUrl;
  String backgroundImageUrl;

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["tel"] = this.tel;
    map["imageUrl"] = this.imageUrl;
    map["backgroundImageUrl"] = this.backgroundImageUrl;
    return map;
  }

  String toString() {
    return jsonEncode(this.toJson());
  }

  fromJson(Map json) {
    id = json["id"];
    name = json["nickname"];
    tel = json["username"];
  }

  get isLogin => this != null && this.id != null && this.id != 0;
}
