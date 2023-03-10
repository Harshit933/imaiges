import 'dart:async';
import 'package:ai_app/views/authviews/data_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    sendVerificationMail();
    if (!isEmailVerified) {
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
    super.initState();
  }

  Future sendVerificationMail() async {
    String res = 'failed';
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      res = 'success';
      SnackBar(
        content: Text('Email has been sent! '),
      );
    } catch (e) {
      SnackBar(
        content: Text("There's some error sending a email"),
      );
      print(e);
    }
    print(res);
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? UserData()
      : Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Verification mail has been sent to your E-mail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'grinched',
                        fontSize: 60,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
