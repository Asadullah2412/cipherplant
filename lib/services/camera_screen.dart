import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

Future<String?> captureImage() async {
  final XFile? image = await picker.pickImage(
    source: ImageSource.camera,
  );

  return image?.path;
}
