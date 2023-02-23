import 'package:ai_app/views/comment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../Backend_methods/fire_store_methods.dart';
import '../models/usermodel.dart';
import '../providers/auth_provider.dart';

class PostWidget extends StatefulWidget {
  final snap;
  const PostWidget({Key? key, this.snap}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  // bool isBookmarked;
  FirestoreMethods _methods = FirestoreMethods();

  bool check(String uid) {
    if (widget.snap['likes'].contains(uid)) {
      return true;
    }

    return false;
  }

  Future<String> getUsername() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.snap['uid'])
        .get();
    DocumentSnapshot data = snapshot.data as DocumentSnapshot;

    return data['usrename'];
    // return FutureBuilder(
    //   future: FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(widget.snap['uid'])
    //       .get(),
    //   builder: ((context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return CircularProgressIndicator();
    //     } else {
    //
    //       return Text(
    //         data['usrename'],
    //         style: TextStyle(
    //             fontSize: 20,
    //             color: CupertinoColors.activeGreen,
    //             fontWeight: FontWeight.bold),
    //       );
    //     }
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    UserModel? _user = Provider.of<AuthProvider>(context).getuser;

    // bool check2(String pid) {
    //   if (_user.bookmarks.contains(pid)) {
    //     return true;
    //   }
    //
    //   return false;
    // }

    return Container(
      // padding: EdgeInsets.only(le),
      color: CupertinoColors.black,
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.snap['uid'])
                      .get(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      DocumentSnapshot data =
                          snapshot.data! as DocumentSnapshot;
                      return Text(
                        data['usrename'],
                        style: TextStyle(
                            fontSize: 20,
                            color: CupertinoColors.activeGreen,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 4, right: 8),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.snap['prompt'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.network(
            widget.snap['images'],
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Row(
              children: [
                /// Add like function
                IconButton(
                    onPressed: () {
                      _methods.addLikes(
                          _user.uid, widget.snap['pid'], widget.snap['likes']);
                    },
                    icon: check(_user.uid)
                        ? Icon(
                            Iconsax.heart,
                            color: Colors.red,
                          )
                        : Icon(
                            Iconsax.heart,
                            color: Colors.white,
                          )),
                SizedBox(
                  width: 10,
                ),

                /// add comment function and comment screen page
                IconButton(
                  onPressed: () {
                    // _methods.addComments(pId: widget.snap['pid'], commentString: 'hello', );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                              pid: widget.snap['pid'],
                            )));
                  },
                  icon: Icon(Iconsax.message),
                  color: CupertinoColors.white,
                  // size: 30,30
                ),
                SizedBox(
                  width: 10,
                ),

                // IconButton(
                //   onPressed: () {
                //     _methods.Addbookmark(
                //         widget.snap['pid'], _user.uid, _user.bookmarks);
                //   },
                //   icon: check2(widget.snap['pid'])
                //       ? Icon(
                //           Iconsax.bookmark,
                //           color: Colors.white,
                //         )
                //       : Icon(Iconsax.bookmark,
                //           color: CupertinoColors.activeGreen),
                //   // size: 30,
                // ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 2),
            child: Row(
              children: [
                Text(
                  '${widget.snap['likes'].length} likes',
                  style: GoogleFonts.poppins(
                    color: CupertinoColors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: "this needs to be fixed ",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeGreen,
                      ),
                      children: [
                        TextSpan(
                          text: widget.snap['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: CupertinoColors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
