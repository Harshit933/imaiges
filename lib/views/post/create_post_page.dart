import 'package:ai_app/models/postmodel.dart';
import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/post_provider.dart';
import 'package:ai_app/service/image_apis.dart';
import 'package:ai_app/views/home_page.dart';
import 'package:ai_app/views/post/view_generated_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController _promptCtrl = TextEditingController();
  TextEditingController _numberOfImagesCtrl = TextEditingController();
  TextEditingController _sizeOfImageCtrl = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;
    // PostModel? _model = Provider.of<PostProvider>(context).model;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Generate Images',
          style: GoogleFonts.poppins(
            color: CupertinoColors.activeGreen,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.75,
                child: TextFormField(
                  controller: _promptCtrl,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  cursorColor: CupertinoColors.activeGreen,
                  minLines: 2,
                  maxLines: 7,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CupertinoColors.activeGreen,
                        width: 3,
                      ),
                    ),
                    hintText:
                        "Enter the description of the photo you want to generate ",
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
                  controller: _numberOfImagesCtrl,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  cursorColor: CupertinoColors.activeGreen,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: CupertinoColors.activeGreen,
                        width: 3,
                      ),
                    ),
                    hintText: "Number of images",
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
                  controller: _sizeOfImageCtrl,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
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
                    hintText: "Size of Image",
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
                  setState(() {
                    isLoading = true;
                  });

                  String img = await Apis.generateImage(
                    NumberOfImages: int.parse(_numberOfImagesCtrl.text),
                    prompt: _promptCtrl.text.trim(),
                    size: _sizeOfImageCtrl.text,
                  );

                  setState(() {
                    isLoading = false;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPage(
                        images: img,
                        size: _sizeOfImageCtrl.text.trim(),
                        prompt: _promptCtrl.text.trim(),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.75,
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Generate ',
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
