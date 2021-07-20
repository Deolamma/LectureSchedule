import 'dart:io';

import 'package:file_picker/file_picker.dart';

class PdfModel {
  static Future<File?> pickFile() async {
    //we need to add file_picker dependencies to our pubspec.yaml

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    //if the user didn't pick any file then we want to return null;
    if (result == null) return null;

    return File(result.paths.first!);
  }

  static Future<File?> pickCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null) return null;

    return File(result.paths.first!);
  }
}
