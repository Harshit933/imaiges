import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String prompt;
  String description;
  String images;
  String pid;
  String size;
  String uid;
  List<String> likes;

  PostModel({
    required this.images,
    required this.prompt,
    required this.description,
    required this.pid,
    required this.size,
    required this.uid,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'images': images,
        'prompt': prompt,
        'pid': pid,
        'size': size,
        'uid': uid,
        'likes': likes,
      };

  static PostModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
      prompt: snap['prompt'],
      description: snap['description'],
      images: snap['images'],
      pid: snap['pid'],
      size: snap['size'],
      uid: snap['uid'],
      likes: snap['likes'],
    );
  }
}
