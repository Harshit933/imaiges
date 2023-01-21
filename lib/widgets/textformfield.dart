import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  final Function? fun;
  final double? width;
  const TextForm({Key? key, this.fun, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width! * 0.75,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Enter your password ",
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: CupertinoColors.activeGreen, width: 3),
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.black,
        ),
      ),
    );
  }
}
