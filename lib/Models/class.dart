import 'package:flutter/foundation.dart';

class Class with ChangeNotifier {
  final String? id;
  final int? level;
  final String? courseCode;
  final String? courseTitle;
  final String? startDate;
  final String? endDate;
  final String? timeOfLecture;

  Class({
    this.id,
    this.level,
    this.courseCode,
    this.courseTitle,
    this.startDate,
    this.endDate,
    this.timeOfLecture,
  });
}
