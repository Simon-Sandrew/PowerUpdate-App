import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GradeStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/grades.txt');
  }

  Future<File> writeGrades(List grades) async {
    final file = await _localFile;
    return file.writeAsString(grades.join("%"));
  }

  Future<List> readGrades() async {
    try {
      final file = await _localFile;
      String content = await file.readAsString();
      return content.split("%");
    } catch (e) {
      return null;
    }
  }
}
