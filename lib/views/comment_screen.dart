import 'package:ai_app/Backend_methods/fire_store_methods.dart';
import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final pid;
  const CommentsScreen({Key? key, required this.pid}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  getComments() {
    final xd = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.pid)
        .collection('comments')
        .snapshots();

    return xd;
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;
    TextEditingController _commentCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Comments',
        ),
        titleTextStyle: GoogleFonts.poppins(
          color: CupertinoColors.activeGreen,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: (snapshot.data as dynamic).docs.length,
                itemBuilder: (context, index) => CommentUI(
                      snap: (snapshot.data as dynamic).docs[index].data(),
                    ));
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _commentCtrl,
                  cursorHeight: 15,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CupertinoColors.activeGreen, width: 3),
                    ),
                    hintText: "Comment as ${_user.username}",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
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
              IconButton(
                onPressed: () async {
                  FirestoreMethods _methods = FirestoreMethods();
                  await _methods.addComments(
                      pId: widget.pid,
                      username: _user.username,
                      commentString: _commentCtrl.text.trim(),
                      uid: _user.uid);

                  setState(() {
                    _commentCtrl.text = "";
                  });
                },
                icon: Icon(
                  Iconsax.arrow_right,
                  color: CupertinoColors.activeGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentUI extends StatelessWidget {
  final snap;
  const CommentUI({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '${snap['username']} ',
              style: GoogleFonts.poppins(color: CupertinoColors.activeGreen)),
          TextSpan(
              text: snap['comment'],
              style: GoogleFonts.poppins(color: CupertinoColors.white)),
        ]),
      ),
    );
  }
}
