import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMethods {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  var followers = [];

  Future<void> getFollowers() async {
    try {
      DocumentSnapshot snap =
          await _store.collection('users').doc(_auth.currentUser!.uid).get();
      // return snap['followers'];
      followers = snap['followers'];
    } catch (e) {
      throw e;
    }
  }
}
