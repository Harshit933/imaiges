import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String prompt;
  String description;
  List<String> images;
  String pid;

  PostModel({
    required this.images,
    required this.prompt,
    required this.description,
    required this.pid,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'images': images,
        'prompt': prompt,
        'pid': pid,
      };

  static PostModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
      prompt: snap['prompt'],
      description: snap['description'],
      images: snap['images'],
      pid: snap['pid'],
    );
  }
}
