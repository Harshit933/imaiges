import 'package:ai_app/Backend_methods/fire_store_methods.dart';
import 'package:ai_app/widgets/post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RealHomePage extends StatefulWidget {
  const RealHomePage({Key? key}) : super(key: key);

  @override
  State<RealHomePage> createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Feed',
        ),
        titleTextStyle: GoogleFonts.poppins(
          color: CupertinoColors.activeGreen,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () => logOut(),
                  child: Text('Log Out'),
                ),
              ),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PostWidget(
                      snap: snapshot.data!.docs[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
