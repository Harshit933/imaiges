import 'package:ai_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name;
  final String username;
  final String about;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String uid;
  final List<dynamic> bookmarks;

  const UserModel({
    required this.name,
    required this.username,
    required this.about,
    required this.followers,
    required this.following,
    required this.uid,
    required this.bookmarks,
  });

  /// Change usrename to username

  Map<String, dynamic> toJson() => {
        'name': name,
        'usrename': username,
        'about': about,
        'followers': followers,
        'following': following,
        'uid': uid,
        'bookmarks': bookmarks,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot['usrename'],
      uid: snapshot['uid'],
      name: snapshot['name'],
      about: snapshot['about'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      bookmarks: snapshot['bookmarks'],
    );
  }
}
