import 'dart:io';
import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/auth_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'desc_page.dart';

class ViewPage extends StatefulWidget {
  final String images;
  final String prompt;
  final String size;
  const ViewPage({
    Key? key,
    required this.images,
    required this.size,
    required this.prompt,
  }) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

/// Here we have to put a download file from network image function and then have to upload to the cloud.

class _ViewPageState extends State<ViewPage> {
  late String downLoadUrl = '';
  final xd = Uuid().v4();

  bool isLoading = false;

  /// returns 1 if this cases
  Future<int> downloadImage(String uid) async {
    int res = 0;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var dio = Dio();
    try {
      final response = await dio.download(
        '${widget.images}',
        '$tempPath/images/$xd.jpg',
      );
      res = res++;
    } catch (e) {
      throw e;
    }
    return res;
  }

  /// returns 1 if the image is successfully uploaded to the server.
  Future<int> uploadImage(String uid) async {
    int res = 0;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '${tempPath}/images/$xd.jpg';
    File file = File(filePath);
    final storageRef = FirebaseStorage.instance.ref();
    final postTempId = const Uuid().v4();
    final StorageRef = storageRef.child('posts').child(uid).child(postTempId);
    try {
      TaskSnapshot task = await StorageRef.putFile(file);
      downLoadUrl = await task.ref.getDownloadURL();
      res++;
    } catch (e) {
      throw e;
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // PostModel? _model = Provider.of<PostProvider>(context).model;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;

    return Scaffold(
      backgroundColor: CupertinoColors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('generated images'),
        backgroundColor: CupertinoColors.black,
        titleTextStyle: GoogleFonts.poppins(
          color: CupertinoColors.activeGreen,
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: PhotoView(
                imageProvider: NetworkImage(widget.images),
              ),
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await downloadImage(_user.uid);
                await uploadImage(_user.uid);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      size: widget.size,
                      imageurl: downLoadUrl,
                      prompt: widget.prompt,
                    ),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                height: height * 0.09,
                width: width * 0.75,
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Share on profile',
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
            ElevatedButton(
              onPressed: () {
                downloadImage(_user.uid);
              },
              child: Text('Download Image'),
            ),
          ],
        ),
      ),
    );
  }
}
