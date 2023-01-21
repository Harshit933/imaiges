import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  String email;
  String password;

  AuthMethods({required this.email, required this.password});

  var user = FirebaseAuth.instance.currentUser;

  Future logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
    } on FirebaseAuthException catch (e) {
      /// SHOW SNACKBAR HERE
      /// Implement all the exceptions
      print(e);
    }
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future verifyEmail() async {
    try {
      if (await !FirebaseAuth.instance.currentUser!.emailVerified) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

}
