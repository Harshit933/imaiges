import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RealHomePage extends StatefulWidget {
  const RealHomePage({Key? key}) : super(key: key);

  @override
  State<RealHomePage> createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    user();
    super.initState();
  }

  void user() async {
    final _auth = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(_auth['name']);
    print(_auth['usrename']);
    print(_auth['about']);
    print(_auth['followers']);
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => logOut(),
                child: Text('Log Out'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
