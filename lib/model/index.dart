import 'package:flutter/material.dart';

class Index with ChangeNotifier {
  int _index = 0;

  set setIndex(newValue) {
    _index = newValue;
    notifyListeners();
  }

  int get getIndex => _index;
}
