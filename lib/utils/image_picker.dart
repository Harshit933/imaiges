import 'package:image_picker/image_picker.dart';

class PickImage {
  ImagePicker _picker = ImagePicker();

  Future imgpick() async {
    String res = '';
    XFile? _file;
    try {
      _file = await _picker.pickImage(source: ImageSource.gallery);
      if (_file != null) {
        res = 'Success';
      }
    } on ImagePicker catch (e) {
      res = 'failed';
    }
    return _file;
  }
}
