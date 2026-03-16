import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import '../services/inference_service.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  InferenceService inferenceService = InferenceService();

// image preprocess
  Future<List> preprocessImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();

    img.Image? original = img.decodeImage(bytes);

    img.Image resized = img.copyResize(original!, width: 224, height: 224);

    List input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            final pixel = resized.getPixel(x, y);

            return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
          },
        ),
      ),
    );

    return input;
  }

// pick image
  Future pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File file = File(image.path);

      setState(() {
        imageFile = file;
      });

      List input = await preprocessImage(file);

      bool leaf = inferenceService.isLeaf(input);

      if (!leaf) {
        print("Not a leaf image");
        return;
      }

      List<double> output = inferenceService.runInference(input);

      int index = inferenceService.getMaxIndex(output);

      List<String> labels = await inferenceService.loadLabels();

      String prediction = labels[index];

      print("Prediction: $prediction");
    }
  }

  @override
  void initState() {
    super.initState();
    inferenceService.loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CipherPlant"),
      ),
      body: Center(
        child: imageFile == null
            ? const Text("No image selected")
            : Image.file(imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
