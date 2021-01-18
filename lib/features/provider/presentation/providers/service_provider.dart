import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  bool _isHome = true;
  bool get isHome => _isHome;

  void toggleHome() {
    _isHome = !_isHome;
    notifyListeners();
  }
}
