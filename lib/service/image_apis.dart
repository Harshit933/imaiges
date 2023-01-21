import 'dart:convert';

import 'package:http/http.dart' as http;

class Apis {
  static const String key =
      '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';
  static const String baseUrl = 'api.openai.com';
  static const Map<String, String> header = {
    'Authorization': 'Bearer ${Apis.key}',
    'Content-Type': 'application/json',
  };

  int n = 1;

  /// generate images
  static Future<List<String>> generateImage({
    required String prompt,
    required String size,
    required int NumberOfImages,
  }) async {
    List<String> images = [];

    /// have to change prompt in the body to the custom value
    http.Response response = await http.post(
      Uri.https(Apis.baseUrl, '/v1/images/generations'),
      headers: Apis.header,
      body: jsonEncode(<String, dynamic>{
        'prompt': '${prompt}',
        'n': NumberOfImages,
        'size': size,
      }),
    );

    var t = jsonDecode(response.body);
    print(t);

    for (int i = 0; i < NumberOfImages - 1; i++) {
      images.add(t['data'][NumberOfImages]['url']);
    }
    // / TO get all the data from
    // images.add(t['data'][0]['url']);
    return images;
  }

  /// Creating images

  Future<List<String>> editImage() async {
    List<String> images = [];

    /// have to change prompt in the body to the custom value
    http.Response response = await http.post(
      Uri.https(Apis.baseUrl, '/v1/images/edits'),
      headers: header,
      body: jsonEncode(<String, String>{
        /// how images are put into it
        'image': 'Hello baby',
        'prompt': 'A text desc. about the image',
        'n': '1',
        'size': '1024x1024',
        'mask': '',
      }),
    );

    var t = jsonDecode(response.body);

    for (int i = 0; i < n; i++) {
      images.add(t['data'][n]['url']);
    }
    // / TO get all the data from
    // images.add(t['data'][0]['url']);
    return images;
  }

  Future<List<String>> createImagevariation() async {
    List<String> images = [];

    /// have to change image in the body to the custom value
    http.Response response = await http.post(
      Uri.https(Apis.baseUrl, '/v1/images/variations'),
      headers: header,
      body: jsonEncode(<String, String>{
        'image': 'Hello baby',
        'n': '1',
        'size': '1024x1024'
      }),
    );

    var t = jsonDecode(response.body);

    for (int i = 0; i < n; i++) {
      images.add(t['data'][n]['url']);
    }
    // / TO get all the data from
    // images.add(t['data'][0]['url']);
    return images;
  }
}
