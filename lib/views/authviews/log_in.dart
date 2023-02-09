import 'package:ai_app/views/authviews/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend_methods/auth_methods.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
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
                  'Log In',
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
                  controller: _emailCtrl,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  cursorHeight: 15,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CupertinoColors.activeGreen, width: 3),
                    ),
                    hintText: "Enter your E-mail ",
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
                  controller: _passwordCtrl,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password ",
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
              InkWell(
                splashColor: Colors.white,
                highlightColor: Colors.white,
                onTap: () async {
                  AuthMethods meths = AuthMethods(
                    email: _emailCtrl.text.trim(),
                    password: _passwordCtrl.text.trim(),
                  );
                  await meths.logIn();
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  child: Center(
                    child: Text(
                      'Log In',
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
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                      // context.goNamed(AppRouteConstants.signUp);
                    },
                    child: Text(
                      'Sign Up ',
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
