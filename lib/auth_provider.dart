import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = "";

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  void login(String username) {
    _username = username;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _username = "";
    _isLoggedIn = false;
    notifyListeners();
  }
}
