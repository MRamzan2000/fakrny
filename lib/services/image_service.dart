// services/image_service.dart

import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    return picked?.path;
  }

  Future<String?> pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    return picked?.path;
  }
}