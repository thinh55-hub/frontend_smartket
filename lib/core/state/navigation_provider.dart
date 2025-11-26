import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';

class NavigationProvider extends ChangeNotifier {
  MainTab _current = MainTab.home;

  MainTab get current => _current;

  set current(MainTab t) {
    if (_current == t) return;
    _current = t;
    notifyListeners();
  }
}
