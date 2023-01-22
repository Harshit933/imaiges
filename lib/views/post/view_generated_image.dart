import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class ViewPage extends StatefulWidget {
  final List<String> images;
  const ViewPage({Key? key, required this.images}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('generated images'),
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
              child: Container(
                child: PhotoView(
                  imageProvider: NetworkImage(widget.images[0]),
                ),
              ),
            ),
            Container(
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
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
