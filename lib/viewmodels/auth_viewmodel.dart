import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;

  Future<bool> register(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    if (password.length < 4) {
      return false;
    }

    _username = username;
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    _username = username;
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _username = null;
    notifyListeners();
  }
}
