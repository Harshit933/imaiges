import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Backend_methods/firebase_methods.dart';
import '../models/usermodel.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel get getuser => _user!;
  final StorageMethods _auth = StorageMethods();

  Future<void> refreshUser() async {
    UserModel user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
