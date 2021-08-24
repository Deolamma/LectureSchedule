import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import '../Models/class.dart';
import '../Models/exceptionClass.dart';

class ClassProvider with ChangeNotifier {
  List<Class> _classItem = [];
  final String? authToken;
  final String? userId;

  ClassProvider(this.authToken, this.userId, this._classItem);

  List<Class> get classItem {
    return [..._classItem];
  }

  Future<void> addClass(Class nClass) async {
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Classes.json?auth=$authToken');

    try {
      if (_classItem.isNotEmpty) {
        final existingData = _classItem.firstWhereOrNull(
          (classItem) => classItem.courseCode == nClass.courseCode,
        );
        if (_classItem.contains(existingData)) {
          throw ExceptionClass('This Class already exists');
        }
      }
      final response = await http.post(
        url,
        body: json.encode({
          'level': nClass.level,
          'courseCode': nClass.courseCode,
          'courseTitle': nClass.courseTitle,
          'timeOfLecture': nClass.timeOfLecture,
          'location': nClass.location,
          'startDate': nClass.startDate,
          'endDate': nClass.endDate,
        }),
      );

      final newClass = Class(
          id: json.decode(response.body)['name'],
          level: nClass.level,
          courseCode: nClass.courseCode,
          courseTitle: nClass.courseTitle,
          endDate: nClass.endDate,
          location: nClass.location,
          startDate: nClass.startDate,
          timeOfLecture: nClass.timeOfLecture);

      _classItem.add(newClass);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Classes.json?auth=$authToken');

    try {
      final response = await http.get(url);
      List<Class>? loadClassData = [];

      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((dataId, classData) {
        loadClassData.add(
          Class(
            id: dataId,
            level: classData['level'],
            courseCode: classData['courseCode'],
            courseTitle: classData['courseTitle'],
            timeOfLecture: classData['timeOfLecture'],
            location: classData['location'],
            endDate: classData['endDate'],
            startDate: classData['startDate'],
          ),
        );
      });
      _classItem = loadClassData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteClass(String courseCode) async {
    var dataIndex = _classItem
        .indexWhere((classItem) => classItem.courseCode == courseCode);
    final idPath = _classItem[dataIndex].id;
    Class? dataValue = _classItem[dataIndex];
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Classes/$idPath.json?auth=$authToken');

    _classItem.removeWhere((classItem) => classItem.courseCode == courseCode);
    notifyListeners();
    var response = await http.delete(url);
    if (response.statusCode >= 400) {
      _classItem.insert(dataIndex, dataValue);
      notifyListeners();
      throw ExceptionClass('Deleting failed');
    }
    dataValue = null;
  }
}
