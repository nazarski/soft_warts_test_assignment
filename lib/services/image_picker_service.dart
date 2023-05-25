import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _imagePicker = ImagePicker();

  ///Pick an Image and encode
  Future<String> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 1);
    if (image == null) return '';
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }
}
