import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class InferenceService {
  late Interpreter interpreter;
  late Interpreter leafInterpreter;

  Future loadModel() async {
    interpreter =
        await Interpreter.fromAsset('assets/models/cipherplant.tflite');
    leafInterpreter = await Interpreter.fromAsset('assets/models/leaf.tflite');
    print("Models loaded successfully");
  }

  bool isLeaf(List input) {
    var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    leafInterpreter.run(input, output);

    double probability = output[0][0];

    print("NOT Leaf probability: $probability");

    return probability < 0.8;
  }

  int getMaxIndex(List<double> predictions) {
    double maxVal = predictions[0];
    int maxIndex = 0;

    for (int i = 1; i < predictions.length; i++) {
      if (predictions[i] > maxVal) {
        maxVal = predictions[i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }

  Future<List<String>> loadLabels() async {
    final labelsData = await rootBundle.loadString('assets/labels/labels.txt');
    return labelsData.split('\n');
  }

  List<double> runInference(List input) {
    var output = List.filled(1 * 6, 0.0).reshape([1, 6]);

    interpreter.run(input, output);

    return List<double>.from(output[0]);
  }

  Future<String> getLLMResponse(String prediction) async {
    // temporary mock (we’ll replace with real API)
    await Future.delayed(const Duration(seconds: 1));

    return """
Disease: $prediction

Cause:
This disease is caused by fungal infection in humid conditions.

Treatment:
• Remove infected leaves
• Apply fungicide
• Avoid overwatering

Prevention:
• Ensure good airflow
• Use healthy seeds
""";
  }

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
}
