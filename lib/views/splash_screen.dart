import 'package:ai_app/views/home_page.dart';
import 'package:ai_app/views/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAuth = false;
  @override
  void initState() {
    check();
    super.initState();
  }

  void check() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _isAuth = true;
        print('User is currently signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isAuth ? HomePage() : LogInPage();
  }
}
