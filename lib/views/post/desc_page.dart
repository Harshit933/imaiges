import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_app/Backend_methods/fire_store_methods.dart';
import 'package:ai_app/models/postmodel.dart';
import 'package:ai_app/views/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../models/usermodel.dart';
import '../../providers/auth_provider.dart';
import '../../providers/post_provider.dart';
import 'package:dio/dio.dart';

class DescriptionPage extends StatefulWidget {
  final String prompt;
  final String imageurl;
  final String size;
  const DescriptionPage(
      {Key? key,
      required this.prompt,
      required this.imageurl,
      required this.size})
      : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final _descriptionController = TextEditingController();

  downloadImage() async {
    var dio = Dio();
    var res;
    Directory dir = await getApplicationDocumentsDirectory();
    try {
      res = await dio.downloadUri(
          Uri.parse(widget.imageurl), '${dir.path}/file.png');
    } catch (e) {
      print(e);
    }

    final result = Uint8List(int.parse(res));

    // final result = Uint8List(res);
    print(result.runtimeType);

    // final data = await res.toByteData();
    // final result = data.buffer.asUint8List();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.black,
        centerTitle: true,
        title: Text('imAIges'),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.activeGreen,
        ),
      ),
      backgroundColor: CupertinoColors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tell us something about this picture',
                  style: GoogleFonts.poppins(
                      // fontFamily: 'grinched',
                      fontSize: 18,
                      color: CupertinoColors.white),
                ),
              ),
              SizedBox(
                width: width * 0.75,
                child: TextFormField(
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: 7,
                  // controller: _sizeOfImageCtrl,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.white),
                  cursorColor: CupertinoColors.activeGreen,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: CupertinoColors.activeGreen,
                        width: 3,
                      ),
                    ),
                    hintText: "Enter some description about image",
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
                  FirestoreMethods meth = FirestoreMethods();
                  String res = await meth.postImage(
                    prompt: widget.prompt,
                    size: widget.size,
                    description: _descriptionController.text.trim(),
                    photoUrl: widget.imageurl,
                    uid: _user.uid,
                  );

                  // final pid = Uuid().v1();

                  // _model.pid = pid;
                  // _model.description = _descriptionController.text.trim();
                  // String res = await meth.postImage2(model: _model);

                  if (res == 'success') {
                    // PostProvider _pr = PostProvider();
                    // _pr.refreshContent();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  } else {
                    /// THROW ERROR HERE!
                    SnackBar(
                      content: Text(res),
                    );
                  }

                  // downloadImage();
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  child: Center(
                    child: Text(
                      'Post ',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    border: Border.all(width: 3, color: Colors.green),
                    borderRadius: const BorderRadius.all(
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
