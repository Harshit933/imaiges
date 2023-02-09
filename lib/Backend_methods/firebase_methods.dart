import 'package:ai_app/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _userid = FirebaseAuth.instance.currentUser;
  List<String> followers = [];

  Future<String> userDetails({
    required String username,
    required String name,
    required String About,
  }) async {
    String res = '';
    UserModel model = UserModel(
      name: name,
      username: username,
      about: About,
      followers: [],
      following: [],
      uid: _userid!.uid,
      bookmarks: [],
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userid!.uid)
          .set(model.toJson());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      print(e);
    }
    return res;
  }

  Future<UserModel> getUserDetails() async {
    User _user = _auth.currentUser!;

    final snap = await _firestore.collection('users').doc(_user.uid).get();

    // getting the data from the user model in form of map
    return UserModel.fromSnap(snap);
  }
}
