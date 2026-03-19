import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'dart:typed_data';
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
  String resultText = "";
  Map<String, dynamic>? resultData;
  bool isLoading = false;

// image preprocess
  Future<List> preprocessLeafImage(File imageFile) async {
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

            return [
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0,
            ];
          },
        ),
      ),
    );

    return input;
  }

// pick image
  // Future pickImage() async {
  //   final XFile? image = await picker.pickImage(source: ImageSource.camera);

  //   if (image != null) {
  //     File file = File(image.path);

  //     setState(() {
  //       imageFile = file;
  //       resultText = "Processing...";
  //     });

  //     List input = await preprocessLeafImage(file);

  //     bool leaf = inferenceService.isLeaf(input);

  //     if (!leaf) {
  //       // print("Not a leaf image");
  //       setState(() {
  //         resultText = "❌ Please scan a plant leaf 🌿";
  //       });
  //       return;
  //     }

  //     List<double> output = inferenceService.runInference(input);

  //     int index = inferenceService.getMaxIndex(output);

  //     List<String> labels = await inferenceService.loadLabels();

  //     String prediction = labels[index];
  //     String explanation = await inferenceService.getLLMResponse(prediction);
  //     setState(() {
  //       resultText = explanation;
  //     });
  //     // print("Prediction: $prediction");
  //   }
  // }
  Widget buildResultCard() {
    final explanation = resultData!['explanation'];

    final disease = explanation['disease'].toString().toLowerCase();
    bool isHealthy = disease.contains("healthy");

    Color headerColor = isHealthy ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isHealthy ? Icons.check_circle : Icons.warning,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      explanation['disease'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 📄 CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confidence: ${explanation['confidence']}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  // Cause
                  Row(
                    children: const [
                      Icon(Icons.biotech, size: 18),
                      SizedBox(width: 6),
                      Text("Cause",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(explanation['cause']),

                  const SizedBox(height: 16),

                  // Treatment
                  Row(
                    children: const [
                      Icon(Icons.healing, size: 18),
                      SizedBox(width: 6),
                      Text("Treatment",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),

                  ...List.generate(
                    explanation['treatment'].length,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text("• ${explanation['treatment'][i]}"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Prevention
                  Row(
                    children: const [
                      Icon(Icons.shield, size: 18),
                      SizedBox(width: 6),
                      Text("Prevention",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),

                  ...List.generate(
                    explanation['prevention'].length,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text("• ${explanation['prevention'][i]}"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File file = File(image.path);

      setState(() {
        imageFile = file;

        isLoading = true;
        resultData = null;
      });

      try {
        var response = await inferenceService.sendImageToAPI(file);

        print("FULL RESPONSE: $response");

        // resultText = "Prediction: ${response['prediction']}";
        setState(() {
          resultData = response;

          isLoading = false;
        });
      } catch (e) {
        print("Error: $e");

        setState(() {
          resultText = "Error connecting to API";
        });
      }
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
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Color(0xFFE8F5E9), Colors.white],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
            ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                if (imageFile != null) Image.file(imageFile!, height: 350),

                const SizedBox(height: 20),

                // 🔄 Loading
                if (isLoading) const CircularProgressIndicator(),

                // ❌ Error case
                if (resultData != null && resultData!['explanation'] == null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      resultData!['message'] ?? "Something went wrong",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // ✅ SUCCESS CASE (THIS WAS MISSING)
                if (resultData != null && resultData!['explanation'] != null)
                  buildResultCard(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
