import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendImageToAPI(File imageFile) async {
  var uri = Uri.parse("http://192.168.0.3:8000/predict");

  var request = http.MultipartRequest("POST", uri);

  request.files.add(
    await http.MultipartFile.fromPath('file', imageFile.path),
  );

  var response = await request.send();

  var responseData = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    return jsonDecode(responseData);
  } else {
    throw Exception("API Error: ${response.statusCode}");
  }
}
