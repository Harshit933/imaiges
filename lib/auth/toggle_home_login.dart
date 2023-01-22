import 'package:ai_app/providers/auth_provider.dart';
import 'package:ai_app/views/home_page.dart';
import 'package:ai_app/views/authviews/log_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../views/authviews/verify_otp.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  Future<void> addData() async {
    AuthProvider _user = Provider.of(context, listen: false);
    await _user.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    // final _userprovider = Provider.of<AuthProvider>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (auth.currentUser!.emailVerified) {
              return HomePage();
            } else {
              return VerifyPage();
            }
          } else {
            return LogInPage();
          }
        },
      ),
    );
  }
}
