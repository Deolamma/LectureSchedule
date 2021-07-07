import 'package:flutter/material.dart';
import '../Models/class.dart';

class ClassProvider with ChangeNotifier {
  List<Class> _classItem = [];

  List<Class> get classItem {
    return [..._classItem];
  }

  void addClass(Class nClass) {
    var newClass = Class(
        level: nClass.level,
        courseCode: nClass.courseCode,
        courseTitle: nClass.courseTitle,
        endDate: nClass.endDate,
        startDate: nClass.startDate,
        timeOfLecture: nClass.timeOfLecture);
    _classItem.add(newClass);
    print(_classItem.length);
    notifyListeners();
  }
}
