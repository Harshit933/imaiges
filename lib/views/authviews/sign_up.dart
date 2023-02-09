import 'package:ai_app/utils/verify_email.dart';
import 'package:ai_app/views/authviews/log_in.dart';
import 'package:ai_app/views/authviews/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend_methods/auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmpassCtrl = TextEditingController();

  bool check() {
    if (_passCtrl.text.trim() == _confirmpassCtrl.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontFamily: 'grinched',
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: width * 0.75,
                height: 60,
                child: TextFormField(
                  cursorHeight: 15,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  controller: _emailCtrl,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: CupertinoColors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CupertinoColors.activeGreen,
                        width: 3,
                      ),
                    ),
                    hintText: "Enter your E-mail",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // focusedBorder: Colors.green,
                    filled: true,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: width * 0.75,
                child: TextFormField(
                  cursorHeight: 15,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  controller: _passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: CupertinoColors.white,
                    ),
                    hintText: "Enter your password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CupertinoColors.activeGreen, width: 3),
                    ),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: width * 0.75,
                height: 60,
                child: TextFormField(
                  obscureText: true,
                  controller: _confirmpassCtrl,
                  cursorHeight: 15,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: CupertinoColors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CupertinoColors.activeGreen, width: 3),
                    ),
                    hintText: "Confirm your password",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // focusedBorder: Colors.green,
                    filled: true,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                // splashColor: Colors.white,
                // highlightColor: Colors.white,
                onTap: () async {
                  print('hello');
                  if (check()) {
                    AuthMethods methods = AuthMethods(
                      email: _emailCtrl.text.trim(),
                      password: _passCtrl.text.trim(),
                    );
                    await methods.signUp();
                    // VerifyEmail(Email: _emailCtrl.text.trim()).sendMail();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyPage(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: CupertinoColors.white,
                          title: Text('Check your password again'),
                          titleTextStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          content: Text(
                            "Both the passwords doesn't match",
                          ),
                          actionsPadding: EdgeInsets.only(
                            right: 12,
                            bottom: 12,
                          ),
                          actions: [
                            InkWell(
                              onTap: () => {Navigator.pop(context)},
                              child: Text(
                                'Ok',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.activeGreen),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    border: Border.all(width: 3, color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member? ',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                    child: Text(
                      'Log In ',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: CupertinoColors.activeGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
