import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

class InferenceService {
  late Interpreter interpreter;
  late Interpreter leafInterpreter;

  Future loadModel() async {
    interpreter =
        await Interpreter.fromAsset('assets/models/cipherplant.tflite');
    leafInterpreter =
        await Interpreter.fromAsset('assets/models/leaf_model.tflite');
    print("Models loaded successfully");
  }

  bool isLeaf(List input) {
    var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    leafInterpreter.run(input, output);

    double probability = output[0][0];

    print("Leaf probability: $probability");

    return probability > 0.5;
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
}
