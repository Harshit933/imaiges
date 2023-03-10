import 'dart:io';

import 'package:ai_app/models/postmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final _user = FirebaseAuth.instance.currentUser!;
  final _firebase = FirebaseFirestore.instance;

  Future<String> postImage({
    required String prompt,
    required String size,
    required String description,
    required String photoUrl,
    required String uid,
  }) async {
    final uuid = Uuid().v1();

    PostModel model = PostModel(
      prompt: prompt,
      images: photoUrl,
      description: description,
      pid: uuid,
      size: size,
      uid: uid,
      likes: [],
    );

    String res = '';
    try {
      await _firebase.collection('posts').doc(uuid).set(model.toJson());

      /// store the postId in the usermodel also
      await _firebase.collection('users').doc(uid).update({
        'posts': FieldValue.arrayUnion([pid]),
      });

      res = 'success';
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
      res = 'failed';
    }
    return res;
  }

  Future<String> postImage2({required PostModel model}) async {
    String res = '';
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(model.pid)
          .set(model.toJson());

      res = 'success';
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
      res = 'failed';
    }
    return res;
  }

  Future<String> addComments({
    required String pId,
    required String username,
    required commentString,
    required String uid,
  }) async {
    String res;
    try {
      await _firebase
          .collection('posts')
          .doc(pId)
          .collection('comments')
          .doc()
          .set({
        'comment': commentString,
        'uid': uid,
        'pid': pId,
        'username': username,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
      print(e);
    }

    return res;
  }

  Future<void> addLikes(String uid, String postId, List likes) async {
    try {
      // if the user has already liked this post then remove it from his likes
      if (likes.contains(uid)) {
        await _firebase.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        // else we will like the post
        await _firebase.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print("Some error occured" + "${e}");
    }
  }

  Future<String> Addbookmark(String postId, String uid, List bookmarks) async {
    String res = 'try again';
    try {
      if (bookmarks.contains(postId)) {
        await _firebase.collection('users').doc(uid).update({
          'bookmarks': FieldValue.arrayRemove([postId]),
        });
      } else {
        await _firebase.collection('users').doc(uid).update({
          'bookmarks': FieldValue.arrayUnion([postId]),
        });
      }
    } catch (e) {
      print("Some error occured" + "${e}");
    }

    return res;
  }

  /// function to check whether the post is already bookmarked or not
  bool isBookmarked(String pid, String uid, List bookmarks) {
    if (bookmarks.contains(pid)) {
      return true;
    }
    return false;
  }

  bool isLiked(String pid, String uid, List likes) {
    if (likes.contains(uid)) {
      return true;
    }
    return false;
  }

  /// When storing the post, make sure to store the postId in the posts section of the user.
  // Future<String> storePostId(String uid, String pid) async {
  //   String res = 'failed';
  //   try {
  //     await _firebase.collection('users').doc(uid).update({
  //       'posts': FieldValue.arrayUnion([pid]),
  //     });
  //     res = 'success';
  //   } catch (e) {
  //     throw e;
  //   }
  //   return res;
  // }
}
