import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getLocalFile(String fileName) async {
  final path = await _localPath;
  return File('$path/$fileName');
}

Future<File> writeFile(String data, String fileName) async {
  final file = await getLocalFile(fileName);

  // Write the file
  return file.writeAsString(data);
}
Future<String> readFile(String fileName) async {
  try {
    final file = await getLocalFile(fileName);

    // Read the file
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}
