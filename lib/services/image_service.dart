import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getImageFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
