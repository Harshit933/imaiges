import 'package:ai_app/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  var user = FirebaseAuth.instance.currentUser;
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
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set(model.toJson());
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      print(e);
    }
    return res;
  }
}
