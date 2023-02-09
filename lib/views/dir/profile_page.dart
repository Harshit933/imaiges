import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageID = '';
  Future<void> addData() async {
    AuthProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  Future downloadImage2() async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
          "https://www.shutterstock.com/image-photo/surreal-image-african-elephant-wearing-260nw-1365289022.jpg");
      if (imageId == null) {
        return;
      }

      print(imageId);

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      print(imageId.runtimeType);
      setState(() {
        imageID = imageId;
      });
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    downloadImage2();
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(_user.username.toString()),
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: CupertinoColors.activeGreen,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: CupertinoColors.activeGreen,
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      _user.name,
                      style: GoogleFonts.poppins(
                        color: CupertinoColors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Flexible(
                      child: Text(
                        _user.about,
                        style: GoogleFonts.poppins(
                          color: CupertinoColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
