import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class InferenceService {
  late Interpreter interpreter;
  late List<String> labels;

  Future loadModel() async {
    interpreter = await Interpreter.fromAsset('models/cipherplant.tflite');

    final labelData = await rootBundle.loadString('assets/labels/labels.txt');
    labels = labelData.split('\n');
    print("Input Shape: ${interpreter.getInputTensor(0).shape}");
    print("Output Shape: ${interpreter.getOutputTensor(0).shape}");
  }

  Future<Map<String, dynamic>> predict(List inputTensor) async {
    final output = List.generate(1, (_) => List.filled(labels.length, 0.0));

    interpreter.run(inputTensor, output);

    final scores = output[0];

    double maxScore = scores[0];
    int maxIndex = 0;

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxScore = scores[i];
        maxIndex = i;
      }
    }

    return {"label": labels[maxIndex], "confidence": maxScore};
  }
}
