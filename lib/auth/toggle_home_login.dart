import 'package:ai_app/views/home_page.dart';
import 'package:ai_app/views/log_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../views/verify_otp.dart';

class Toggle extends StatelessWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder<User?>(
      stream: auth.idTokenChanges(),
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
    );
  }
}
