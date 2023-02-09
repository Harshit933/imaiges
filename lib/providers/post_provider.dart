import 'package:ai_app/models/postmodel.dart';
import 'package:flutter/cupertino.dart';

class PostProvider with ChangeNotifier {
  PostModel? _model;
  PostModel get model => _model!;

  Future<void> getPostInfo(PostModel model) async {
    _model = model;
    ChangeNotifier();
  }

  void refreshContent() {
    _model = null;
  }
}
