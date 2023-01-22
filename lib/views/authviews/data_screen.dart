import 'package:ai_app/firebase%20methods/firestore_methods.dart';
import 'package:ai_app/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

/// username, user, profilephoto, bio, followers, following,
class _UserDataState extends State<UserData> {
  final _usernamectrl = TextEditingController();
  final _namectrl = TextEditingController();
  final _bioctrl = TextEditingController();

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
              Text(
                'About you',
                style: TextStyle(
                  fontFamily: 'grinched',
                  color: CupertinoColors.white,
                  fontSize: 70,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: width * 0.75,
                height: 60,
                child: TextFormField(
                  controller: _usernamectrl,
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
                    hintText: "Username",
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
                height: 60,
                child: TextFormField(
                  controller: _namectrl,
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
                    hintText: "Name",
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
                height: 60,
                child: TextFormField(
                  controller: _bioctrl,
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
                    hintText: "About yourself",
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
                onTap: () async {
                  StorageMethods meth = StorageMethods();
                  String res = await meth.userDetails(
                    username: _usernamectrl.text.trim(),
                    name: _namectrl.text.trim(),
                    About: _bioctrl.text.trim(),
                  );
                  if (res != 'success') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: CupertinoColors.white,
                          title: Text("Something went wrong"),
                          titleTextStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          content: Text(
                            "Please try again",
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  child: Center(
                    child: Text(
                      'Next',
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
            ],
          ),
        ),
      ),
    );
  }
}
