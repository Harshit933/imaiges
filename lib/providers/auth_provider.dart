import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuth = false;

  bool get isAuth => _isAuth;

   check() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _isAuth = true;
      } else {
        print('there is no user');
        _isAuth = false;
      }
    });
    _isAuth = isAuth;
    notifyListeners();
  }
}
