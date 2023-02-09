import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/postmodel.dart';
import '../../providers/post_provider.dart';
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

class _ViewPageState extends State<ViewPage> {
  void downloadImage() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var dio = Dio();
    final response = await dio.download(
      '${widget.images}',
      '$tempPath/images/deer.jpg',
    );
    print(response.data);
    print(response.data.runtimeType);
    // print(response.)
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DescriptionPage(
                    size: widget.size,
                    imageurl: widget.images,
                    prompt: widget.prompt,
                  ),
                ),
              ),
              child: Container(
                height: height * 0.09,
                width: width * 0.75,
                child: Center(
                  child: Text(
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
              onPressed: downloadImage,
              child: Text('Download Image'),
            ),
          ],
        ),
      ),
    );
  }
}
