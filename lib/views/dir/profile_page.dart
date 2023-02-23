import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // String imageID = '';
  Future<void> addData() async {
    AuthProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;

    return _user == null
        ? Text('Please Wait')
        : Scaffold(
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
                        Divider(
                          color: CupertinoColors.activeGreen,
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.all(10),
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Expanded(
                                    child: Container(
                                      child: Image.network(
                                        snapshot[''],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
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
