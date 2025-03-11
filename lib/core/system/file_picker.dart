import 'package:image_picker/image_picker.dart';

class FilePicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImage(ImageSource source, {int imageQuality = 50}) {
    return _picker.pickImage(source: source, imageQuality: imageQuality);
  }

  static Future<List<XFile>?> pickMultiImage({int imageQuality = 50}) {
    return _picker.pickMultiImage(
      imageQuality: imageQuality,
    );
  }
}